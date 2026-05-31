: "${OMADORA_LOG_TAG:=omadora}"

log() {
  local priority="$1"
  shift

  systemd-cat \
    --identifier="$OMADORA_LOG_TAG" \
    --priority="$priority" \
    <<<"$*"
}

log_debug() {
  log debug "$*"
}

log_info() {
  log info "$*"
}

log_warn() {
  log warning "$*"
}

log_error() {
  log err "$*"
}
