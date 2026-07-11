#!/usr/bin/env bash
set -euo pipefail

echo "Migrate Hyprland user config from Hyprlang to Lua..."

hypr_config_dir="$HOME/.config/hypr"
omadora_hypr_config_dir="$OMADORA_PATH/config/hypr"
toggle_state_dir="$HOME/.local/state/omadora/toggles/hypr"
toggle_defaults_dir="$OMADORA_PATH/default/hypr/toggles"
timestamp=$(date +%s)
lua_backups=()
config_backups=()
toggle_backups=()

backup_path() {
  local source="$1"
  local backup="$source.bak.$timestamp"
  local suffix=0

  while [[ -e $backup ]]; do
    ((suffix += 1))
    backup="$source.bak.$timestamp.$suffix"
  done

  printf '%s' "$backup"
}

backup_copy() {
  local source="$1"
  local backup
  backup=$(backup_path "$source")
  cp -p -- "$source" "$backup"
  printf '%s' "$backup"
}

backup_move() {
  local source="$1"
  local backup
  backup=$(backup_path "$source")
  mv -- "$source" "$backup"
  printf '%s' "$backup"
}

mkdir -p "$hypr_config_dir" "$toggle_state_dir"

# Stage the complete replacement set before changing any live configuration.
shopt -s nullglob
lua_sources=("$omadora_hypr_config_dir"/*.lua)
shopt -u nullglob
lua_sources+=("$omadora_hypr_config_dir/.luarc.json")

for required_config in autostart bindings hyprland input looknfeel monitors; do
  required_path="$omadora_hypr_config_dir/$required_config.lua"
  [[ -f $required_path ]] || {
    echo "Missing required Hyprland Lua config: $required_path" >&2
    exit 1
  }
done
[[ -f $omadora_hypr_config_dir/.luarc.json ]] || {
  echo "Missing required Hyprland Lua metadata: $omadora_hypr_config_dir/.luarc.json" >&2
  exit 1
}

staging_dir=$(mktemp -d "$hypr_config_dir/.omadora-lua-migration.XXXXXX")
trap 'rm -rf -- "$staging_dir"' EXIT

for lua_config in "${lua_sources[@]}"; do
  cp -p -- "$lua_config" "$staging_dir/${lua_config##*/}"
done

# Back up every existing managed Lua file before replacing any of them.
for lua_config in "${lua_sources[@]}"; do
  destination="$hypr_config_dir/${lua_config##*/}"
  if [[ -f $destination ]]; then
    lua_backups+=("$(backup_copy "$destination")")
  fi
done

# Atomically replace supporting files before replacing the main entrypoint.
for lua_config in "${lua_sources[@]}"; do
  [[ ${lua_config##*/} == hyprland.lua ]] && continue
  destination="$hypr_config_dir/${lua_config##*/}"
  mv -f -- "$staging_dir/${lua_config##*/}" "$destination"
done

mv -f -- "$staging_dir/hyprland.lua" "$hypr_config_dir/hyprland.lua"

[[ -f $hypr_config_dir/hyprland.lua ]] || {
  echo "Failed to install $hypr_config_dir/hyprland.lua" >&2
  exit 1
}

# Retire legacy configs only after the Lua configuration is in place.
for config_name in autostart bindings hyprland input looknfeel monitors; do
  conf_file="$hypr_config_dir/$config_name.conf"

  if [[ -f $conf_file ]]; then
    config_backups+=("$(backup_move "$conf_file")")
  fi
done

for conf_toggle in "$toggle_state_dir"/*.conf; do
  [[ -f $conf_toggle ]] || continue

  toggle_name=$(basename "$conf_toggle" .conf)
  lua_toggle="$toggle_state_dir/$toggle_name.lua"

  if [[ ! -f $lua_toggle ]]; then
    case "$toggle_name" in
    flags | single-window-aspect-ratio | window-no-gaps)
      if [[ -f $toggle_defaults_dir/$toggle_name.lua ]]; then
        cp -f "$toggle_defaults_dir/$toggle_name.lua" "$lua_toggle"
      fi
      ;;
    internal-monitor-disable)
      monitor=$(sed -nE '/^monitor=([^,]+),disable.*$/{s//\1/;p;q;}' "$conf_toggle")
      if [[ -n $monitor ]]; then
        printf 'hl.monitor({ output = "%s", disabled = true })\n' "$monitor" >"$lua_toggle"
      fi
      ;;
    internal-monitor-mirror)
      monitor_line=$(sed -n '/^monitor=/{p;q;}' "$conf_toggle")
      external=$(printf '%s' "$monitor_line" | cut -d, -f1 | sed 's/^monitor=//')
      internal=$(printf '%s' "$monitor_line" | awk -F',[[:space:]]*mirror,[[:space:]]*' '{ print $2 }')
      if [[ -n $external && -n $internal ]]; then
        printf 'hl.monitor({ output = "%s", mode = "preferred", position = "auto", scale = 1, mirror = "%s" })\n' "$external" "$internal" >"$lua_toggle"
      fi
      ;;
    touchpad-disabled | touchscreen-disabled)
      device=$(sed -nE '/^[[:space:]]*name[[:space:]]*=[[:space:]]*(.*)$/{s//\1/;p;q;}' "$conf_toggle")
      if [[ -n $device ]]; then
        printf 'hl.device({ name = "%s", enabled = false })\n' "$device" >"$lua_toggle"
      fi
      ;;
    esac
  fi

  toggle_backups+=("$(backup_move "$conf_toggle")")
done

if ((${#lua_backups[@]})); then
  echo
  echo "Existing Lua configs were replaced with new Omadora defaults and backed up:"
  printf '  %s\n' "${lua_backups[@]}"
fi

if ((${#config_backups[@]})); then
  echo
  echo "Legacy user configs were backed up and need manual Lua porting if they contained customizations:"
  printf '  %s\n' "${config_backups[@]}"
fi

if ((${#toggle_backups[@]})); then
  echo
  echo "Legacy toggle files were backed up; supported state was converted when possible:"
  printf '  %s\n' "${toggle_backups[@]}"
fi

sudo touch /run/reboot-required

echo "Hyprland must be restarted to switch from hyprland.conf to hyprland.lua. Log out and back in, or reboot when ready."
