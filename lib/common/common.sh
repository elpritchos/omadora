# shellcheck shell=bash

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

info_heading() {
  printf '\e[32m%s\e[0m\n' "$*"
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

omadora_run() {
  local command="$1"
  shift

  local script="$OMADORA_LIBEXEC_DIR/$command"

  if [[ -x "$script" ]]; then
    "$script" "$@"
  else
    return 1
  fi
}

omadora_exec() {
  local command="$1"
  shift

  local script="$OMADORA_LIBEXEC_DIR/$command"

  if [[ -x "$script" ]]; then
    exec "$script" "$@"
  fi

  die "omadora command not found: $command"
}

omadora_command() {
  local command="$1"
  shift

  local script="$OMADORA_LIBEXEC_DIR/$command"

  if [[ ! -x "$script" ]]; then
    die "omadora command not found: $command"
  fi

  printf '%q' "$script"

  local arg
  for arg in "$@"; do
    printf ' %q' "$arg"
  done
}

ensure_dir() {
  mkdir -p -- "$@"
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

sudo_keepalive() {
  sudo -v || return 1

  (
    while true; do
      sleep 60

      # exit if parent dies
      kill -0 "$PPID" || exit

      # refresh timestamp without triggering auth
      sudo -n true
    done
  ) &
}
