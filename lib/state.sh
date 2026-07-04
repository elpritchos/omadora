state_flag_validate() {
  [[ "$flag" =~ ^[A-Za-z0-9._-]+$ ]] || return 1
  [[ "$flag" != "." && "$flag" != ".." ]] || return 1
}

state_list() {
  [[ -d "$OMADORA_STATE_HOME" ]] || return 0

  find "$OMADORA_STATE_HOME" \
    -maxdepth 1 \
    -type f \
    -printf '%f\n' |
    sort
}

state_set() {
  local flag="${1:-}"

  state_flag_validate "$flag" || return 1

  ensure_dir "$OMADORA_STATE_HOME"
  touch -- "$OMADORA_STATE_HOME/$flag"
}

state_clear() {
  local flag="${1:-}"

  state_flag_validate "$flag" || return 1

  rm -f -- "$OMADORA_STATE_HOME/$flag"
}

state_exists() {
  local flag="${1:-}"

  [[ -f "$OMADORA_STATE_HOME/$flag" ]]
}

state_toggles_list() {
  [[ -d "$OMADORA_STATE_HOME" ]] || return 0

  find "$OMADORA_STATE_HOME/toggles" \
    -maxdepth 1 \
    -type f \
    -printf '%f\n' |
    sort
}

state_toggles_set() {
  local toggle="${1:-}"

  state_flag_validate "$toggle" || return 1

  ensure_dir "$OMADORA_STATE_HOME/toggles"
  touch -- "$OMADORA_STATE_HOME/toggles/$toggle"
}

state_toggles_clear() {
  local toggle="${1:-}"

  state_flag_validate "$toggle" || return 1

  rm -f -- "$OMADORA_STATE_HOME/toggles/$toggle"
}

state_toggles_exists() {
  local toggle="${1:-}"

  [[ -f "$OMADORA_STATE_HOME/toggles/$toggle" ]]
}
