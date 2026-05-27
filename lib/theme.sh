OMADORA_ROOT="${OMADORA_PATH:-$HOME/.local/share/omadora}"
OMADORA_THEMES_DIR="${OMADORA_ROOT}/themes"

OMADORA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/omadora"
OMADORA_USER_THEMES_DIR="${OMADORA_CONFIG_DIR}/themes"
OMADORA_CURRENT_THEME_DIR="${OMADORA_CONFIG_DIR}/current/theme"
OMADORA_NEXT_THEME_DIR="${OMADORA_CONFIG_DIR}/current/next-theme"
OMADORA_THEME_NAME_FILE="${OMADORA_CONFIG_DIR}/current/theme.name"
OMADORA_USER_BACKGROUNDS_DIR="${OMADORA_CONFIG_DIR}/backgrounds"
OMADORA_CURRENT_BACKGROUND_LINK="${OMADORA_CONFIG_DIR}/current/background"

theme_name_normalize() {
  echo "$1" |
    sed -E 's/<[^>]+>//g' |
    tr '[:upper:]' '[:lower:]' |
    tr ' ' '-'
}

theme_exists() {
  theme_list_all | grep -qx -- "$1"
}

theme_current() {
  [[ -f "${OMADORA_THEME_NAME_FILE}" ]] || {
    echo "no current theme set" >&2
    return 1
  }
  cat "$OMADORA_THEME_NAME_FILE"
}

theme_list_user() {
  [[ -d "$OMADORA_USER_THEMES_DIR" ]] && find "$OMADORA_USER_THEMES_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort || true
}

theme_list_system() {
  [[ -d "$OMADORA_THEMES_DIR" ]] && find "$OMADORA_THEMES_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort || true
}

theme_list_all() {
  {
    theme_list_user
    theme_list_system
  } | sort -u
}

# Convert hex color to decimal RGB (e.g., "#1e1e2e" -> "30,30,46")
hex_to_rgb() {
  local hex="${1#\#}"
  printf "%d,%d,%d" "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

theme_set_templates() {
  local colors_file="${OMADORA_NEXT_THEME_DIR}/colors.toml"

  # Only generate dynamic templates for themes with a colors.toml definition
  if [[ -f $colors_file ]]; then
    sed_script=$(mktemp)

    while IFS='=' read -r key value; do
      key="${key//[\"\' ]/}"                # strip quotes and spaces from key
      [[ $key && $key != \#* ]] || continue # skip empty lines and comments
      value="${value#*[\"\']}"
      value="${value%%[\"\']*}" # extract value between quotes (ignores inline comments)

      printf 's|{{ %s }}|%s|g\n' "$key" "$value"            # {{ key }} -> value
      printf 's|{{ %s_strip }}|%s|g\n' "$key" "${value#\#}" # {{ key_strip }} -> value without leading #
      if [[ $value =~ ^# ]]; then
        rgb=$(hex_to_rgb "$value")
        echo "s|{{ ${key}_rgb }}|${rgb}|g"
      fi
    done <"$colors_file" >"$sed_script"

    # TODO: check this
    shopt -s nullglob

    # Process user templates first, then built-in templates (user overrides built-in)
    for tpl in "${OMADORA_CONFIG_DIR}"/themed/*.tpl "${OMADORA_ROOT}"/default/themed/*.tpl; do
      filename=$(basename "$tpl" .tpl)
      output_path="$OMADORA_NEXT_THEME_DIR/$filename"

      # Don't overwrite configs already exists in the output directory (copied from theme specific folder)
      if [[ ! -f $output_path ]]; then
        sed -f "$sed_script" "$tpl" >"$output_path"
      fi
    done

    rm "$sed_script"
  fi
}

theme_set_gnome() {
  # Change gnome modes
  if [[ -f "${OMADORA_CURRENT_THEME_DIR}/light.mode" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
  else
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
  fi

  # Change gnome icon theme color
  local icons_file="${OMADORA_CURRENT_THEME_DIR}/icons.theme"
  if [[ -f "$icons_file" ]]; then
    gsettings set org.gnome.desktop.interface icon-theme "$(<"$icons_file")"
  else
    gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"
  fi
}
