# shellcheck shell=bash

if [[ -z "${OMADORA_ROOT:-}" ]]; then
  printf 'error: OMADORA_ROOT must be set before sourcing paths.sh\n' >&2
  return 1
fi

readonly OMADORA_LIB_DIR="$OMADORA_ROOT/lib"
readonly OMADORA_LIBEXEC_DIR="$OMADORA_ROOT/libexec"
readonly OMADORA_THEMES_DIR="$OMADORA_ROOT/themes"
readonly OMADORA_DEFAULTS_DIR="$OMADORA_ROOT/defaults"
readonly OMADORA_MIGRATIONS_DIR="$OMADORA_ROOT/migrations"

readonly OMADORA_DATA_HOME="${OMADORA_DATA_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/omadora}"
readonly OMADORA_CONFIG_HOME="${OMADORA_CONFIG_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/omadora}"
readonly OMADORA_CONFIG_FILE="${OMADORA_CONFIG_HOME}/config.json"
readonly OMADORA_STATE_HOME="${OMADORA_STATE_HOME:-${XDG_STATE_HOME:-$HOME/.local/state}/omadora}"
readonly OMADORA_CACHE_HOME="${OMADORA_CACHE_HOME:-${XDG_CACHE_HOME:-$HOME/.cache}/omadora}"

if [[ -n "${XDG_RUNTIME_DIR:-}" ]]; then
  readonly OMADORA_RUNTIME_DIR="${OMADORA_RUNTIME_DIR:-$XDG_RUNTIME_DIR/omadora}"
fi
