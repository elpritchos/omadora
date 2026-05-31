if [[ -n "${OMADORA_INITIALIZED:-}" ]]; then
  return 0
fi

readonly OMADORA_INITIALIZED=1

: "${OMADORA_ROOT:=$(
  cd "$(dirname "${BASH_SOURCE[0]}")/../.." &&
    pwd
)}"

export OMADORA_ROOT

: "${OMADORA_DATA_HOME:=${XDG_DATA_HOME:-$HOME/.local/share}/omadora}"
: "${OMADORA_CONFIG_HOME:=${XDG_CONFIG_HOME:-$HOME/.config}/omadora}"
: "${OMADORA_STATE_HOME:=${XDG_STATE_HOME:-$HOME/.local/state}/omadora}"
: "${OMADORA_CACHE_HOME:=${XDG_CACHE_HOME:-$HOME/.cache}/omadora}"

export OMADORA_DATA_HOME
export OMADORA_CONFIG_HOME
export OMADORA_STATE_HOME
export OMADORA_CACHE_HOME

if [[ -n "${XDG_RUNTIME_DIR:-}" ]]; then
  : "${OMADORA_RUNTIME_DIR:=${XDG_RUNTIME_DIR}/omadora}"
  export OMADORA_RUNTIME_DIR
fi

# shellcheck source=lib/common/paths.sh
source "$OMADORA_ROOT/lib/common/paths.sh"

# shellcheck source=lib/common/log.sh
source "$OMADORA_ROOT/lib/common/log.sh"

# shellcheck source=lib/common/errors.sh
source "$OMADORA_ROOT/lib/common/errors.sh"

#source "$OMADORA_ROOT/lib/common/lock.sh"
#source "$OMADORA_ROOT/lib/common/systemd.sh"
