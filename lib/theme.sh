readonly OMADORA_USER_THEMES_DIR="${OMADORA_CONFIG_HOME}/themes"
readonly OMADORA_CURRENT_THEME_DIR="${OMADORA_CONFIG_HOME}/current/theme"
readonly OMADORA_NEXT_THEME_DIR="${OMADORA_CONFIG_HOME}/current/next-theme"
readonly OMADORA_THEME_NAME_FILE="${OMADORA_CONFIG_HOME}/current/theme.name"
readonly OMADORA_USER_BACKGROUNDS_DIR="${OMADORA_CONFIG_HOME}/backgrounds"
readonly OMADORA_CURRENT_BACKGROUND_LINK="${OMADORA_CONFIG_HOME}/current/background"

theme_name_normalize() {
  echo "$1" |
    sed -E 's/<[^>]+>//g' |
    tr '[:upper:]' '[:lower:]' |
    tr ' ' '-'
}

theme_exists() {
  local theme="$1"

  theme_list_all | grep -qxF -- "$theme"
}

theme_current() {
  [[ -s "$OMADORA_THEME_NAME_FILE" ]] || return 1
  head -n 1 -- "$OMADORA_THEME_NAME_FILE"
}

theme_list_user() {
  [[ -d "$OMADORA_USER_THEMES_DIR" ]] || return 0

  find "$OMADORA_USER_THEMES_DIR" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -printf '%f\n' |
    sort
}

theme_list_system() {
  [[ -d "$OMADORA_THEMES_DIR" ]] || return 0

  find "$OMADORA_THEMES_DIR" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -printf '%f\n' |
    sort
}

theme_list_all() {
  {
    theme_list_user || return 1
    theme_list_system || return 1
  } | sort -u
}

theme_list_backgrounds() {
  local theme_name="$1"

  local backgrounds_dir="${OMADORA_USER_BACKGROUNDS_DIR}/${theme_name}"

  [[ -d "$backgrounds_dir" ]] || return 0

  find "$backgrounds_dir" \
    -maxdepth 1 \
    -type f \
    -printf '%f\n' |
    sort
}

# Convert hex color to decimal RGB (e.g., "#1e1e2e" -> "30,30,46")
hex_to_rgb() {
  local hex="${1#\#}"
  printf "%d,%d,%d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

theme_set_templates() {
  local colors_file="${OMADORA_NEXT_THEME_DIR}/colors.toml"

  [[ -f "$colors_file" ]] || return 0

  local sed_script
  sed_script="$(mktemp)" || return 1

  trap 'rm -f "$sed_script"' RETURN

  local key value rgb

  while IFS='=' read -r key value; do
    key="${key//[\"\' ]/}"

    [[ -n "$key" && $key != \#* ]] || continue

    value="${value#*[\"\']}"
    value="${value%%[\"\']*}"

    printf 's|{{ %s }}|%s|g\n' "$key" "$value"
    printf 's|{{ %s_strip }}|%s|g\n' "$key" "${value#\#}"

    if [[ $value == \#* ]]; then
      rgb="$(hex_to_rgb "$value")" || return 1
      printf 's|{{ %s_rgb }}|%s|g\n' "$key" "$rgb"
    fi
  done <"$colors_file" >"$sed_script"

  local tpl filename output_path

  shopt -s nullglob

  for tpl in \
    "${OMADORA_CONFIG_HOME}/themed"/*.tpl \
    "${OMADORA_ROOT}/default/themed"/*.tpl; do

    filename="${tpl##*/}"
    filename="${filename%.tpl}"

    output_path="${OMADORA_NEXT_THEME_DIR}/${filename}"

    [[ -f "$output_path" ]] && continue

    sed -f "$sed_script" "$tpl" >"$output_path" || return 1
  done

  shopt -u nullglob
}

theme_set_gnome() {
  command -v gsettings >/dev/null 2>&1 || return 1

  local light_mode_file="${OMADORA_CURRENT_THEME_DIR}/light.mode"
  local icons_file="${OMADORA_CURRENT_THEME_DIR}/icons.theme"

  local gtk_theme="adw-gtk3-dark"
  local icon_theme="Yaru-blue"
  local color_scheme="prefer-dark"

  if [[ -f "$light_mode_file" ]]; then
    color_scheme="prefer-light"
    gtk_theme="adw-gtk3"
  fi

  if [[ -f "$icons_file" ]]; then
    icon_theme="$(<"$icons_file")"
  fi

  gsettings set org.gnome.desktop.interface color-scheme "$color_scheme"
  gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme"
  gsettings set org.gnome.desktop.interface icon-theme "$icon_theme"
}

theme_apply_background() {
  hyprctl hyprpaper wallpaper ,"$OMADORA_CURRENT_BACKGROUND_LINK"
}
