: "${OMADORA_APP_NAME:=${0##*/}}"

: "${OMADORA_DEBUG:=0}"
: "${OMADORA_ASSUME_YES:=0}"
: "${OMADORA_NO_COLOR:=0}"
: "${OMADORA_QUIET:=0}"

error() {
  printf '%s: error: %s\n' "$OMADORA_APP_NAME" "$*" >&2
}

warn() {
  ((OMADORA_QUIET)) && return 0
  printf '%s: warning: %s\n' "$OMADORA_APP_NAME" "$*" >&2
}

info() {
  ((OMADORA_QUIET)) && return 0
  printf '%s\n' "$*"
}

debug() {
  ((OMADORA_DEBUG)) || return 0
  printf '%s: debug: %s\n' "$OMADORA_APP_NAME" "$*" >&2
}

die() {
  error "$*"
  exit 1
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

require_cmd() {
  local cmd

  for cmd in "$@"; do
    has_cmd "$cmd" || die "missing required command: $cmd"
  done
}

ensure_dir() {
  mkdir -p -- "$1"
}

is_interactive() {
  [[ -t 0 && -t 1 ]]
}

confirm() {
  local prompt=${1:-"Continue?"}
  local reply

  ((OMADORA_ASSUME_YES)) && return 0
  is_interactive || return 1

  if has_cmd gum; then
    gum confirm "$prompt"
    return $?
  fi

  read -r -p "$prompt [y/N] " reply

  case "$reply" in
  y | Y | yes | YES) return 0 ;;
  *) return 1 ;;
  esac
}

run() {
  debug "running: $*"
  "$@"
}

run_as_root() {
  if ((EUID == 0)); then
    run "$@"
  else
    run sudo "$@"
  fi
}

exec_cmd() {
  debug "exec: $(printf '%q ' "$@")"
  exec "$@"
}
