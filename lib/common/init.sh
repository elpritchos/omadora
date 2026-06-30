if [[ -n "${OMADORA_INITIALIZED:-}" ]]; then
  return 0
fi

readonly OMADORA_INITIALIZED=1

readonly OMADORA_ROOT="${OMADORA_ROOT:-$(
  cd -- "$(dirname "${BASH_SOURCE[0]}")/../.." &&
    pwd
)}"

# shellcheck source=paths.sh
source "$OMADORA_ROOT/lib/common/paths.sh"

# shellcheck source=common.sh
source "$OMADORA_ROOT/lib/common/common.sh"
