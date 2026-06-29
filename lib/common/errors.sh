fatal() {
  local message="$1"

  log_error "$message"

  printf 'ERROR: %s\n' "$message" >&2

  exit 1
}

assert_file() {
  local path="$1"

  [[ -f "$path" ]] ||
    fatal "file not found: $path"
}

assert_dir() {
  local path="$1"

  [[ -d "$path" ]] ||
    fatal "directory not found: $path"
}

#require_cmd() {
#  local command="$1"
#
#  command -v "$command" >/dev/null 2>&1 ||
#    fatal "required command not found: $command"
#}

require_env() {
  local variable="$1"

  [[ -n "${!variable:-}" ]] ||
    fatal "required environment variable not set: $variable"
}

require_user() {
  [[ $EUID -ne 0 ]] ||
    fatal "must not be run as root"
}

require_root() {
  [[ $EUID -eq 0 ]] ||
    fatal "must be run as root"
}
