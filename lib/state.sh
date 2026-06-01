state_list() {
  [[ -d "$OMADORA_STATE_HOME" ]] || return 0

  find "$OMADORA_STATE_HOME" \
    -maxdepth 1 \
    -type f \
    -printf '%f\n' |
    sort
}

state_exists() {
  local state="$1"

  [[ -f "$OMADORA_STATE_HOME/$state" ]]
}

state_set() {
  local state="$1"

  [[ -n "$state" ]] || return 1
  [[ "$state" != */* ]] || return 1

  mkdir -p "$OMADORA_STATE_HOME"

  touch "$OMADORA_STATE_HOME/$state"
}

state_clear() {
  local state="$1"

  [[ -n "$state" ]] || return 1
  [[ "$state" != */* ]] || return 1

  rm -f "$OMADORA_STATE_HOME/$state"
}

state_clear_pattern() {
  local pattern="$1"

  [[ -n "$pattern" ]] || return 1

  find "$OMADORA_STATE_HOME" \
    -maxdepth 1 \
    -type f \
    -name "$pattern" \
    -delete
}
