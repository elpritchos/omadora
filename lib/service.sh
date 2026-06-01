service_reload_waybar() {
  if pgrep -x "waybar" >/dev/null; then
    pkill -SIGUSR2 waybar
  fi
}

service_reload_mako() {
  makoctl reload
}

service_reload_hyprland() {
  hyprctl reload
}

service_reload_btop() {
  if pgrep -x "btop" >/dev/null; then
    pkill -SIGUSR2 btop
  fi
}

service_reload_alacritty() {
  local alacritty_config="${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.toml"

  if [[ -f "$alacritty_config" ]]; then
    touch "$alacritty_config"
  fi
}

service_reload_ghostty() {
  if pgrep -x "ghostty" >/dev/null; then
    pkill -SIGUSR2 ghostty
  fi
}

service_reload_kitty() {
  if pgrep -x "kitty" >/dev/null; then
    pkill -SIGUSR1 kitty
  fi
}
