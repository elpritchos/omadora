readonly OMADORA_UPDATE_STATE_DIR="${OMADORA_STATE_HOME}/update"
readonly OMADORA_UPDATE_CACHE_DIR="${OMADORA_CACHE_HOME}/update"

readonly OMADORA_UPDATE_LOCK_FILE="${OMADORA_RUNTIME_DIR}/update.lock"

readonly OMADORA_UPDATE_STATE_FILE="$OMADORA_UPDATE_STATE_DIR/state.json"

readonly OMADORA_UPDATE_DNF_UPGRADES_LIST="$OMADORA_UPDATE_CACHE_DIR/dnf-upgrades.txt"
readonly OMADORA_UPDATE_DNF_ADVISORIES_JSON="$OMADORA_UPDATE_CACHE_DIR/dnf-advisories.json"
readonly OMADORA_UPDATE_FWUPD_JSON="$OMADORA_UPDATE_CACHE_DIR/fwupd.json"
readonly OMADORA_UPDATE_FLATPAK_UPGRADES_LIST="$OMADORA_UPDATE_CACHE_DIR/flatpak-upgrades.txt"
readonly OMADORA_UPDATE_CARGO_UPGRADES_LIST="$OMADORA_UPDATE_CACHE_DIR/cargo-upgrades.txt"

omadora_update=0
dnf_package_total=0
dnf_advisory_total=0
dnf_security_total=0
dnf_bugfix_total=0
dnf_enhancement_total=0
dnf_other_total=0
cargo_total=0
flatpak_total=0
firmware_total=0
with_errors=false

write_atomic() {
  local target="$1"
  local tmp

  tmp="$(mktemp "${target}.tmp.XXXXXX")"

  cat >"$tmp"
  mv "$tmp" "$target"
}

update_dirs_init() {
  ensure_dir \
    "$OMADORA_UPDATE_STATE_DIR" \
    "$OMADORA_UPDATE_CACHE_DIR" \
    "$OMADORA_RUNTIME_DIR"
}

update_collect_omadora() {
  latest_tag=$(git -C "$OMADORA_ROOT" ls-remote --tags origin | grep -v "{}" | awk '{print $2}' | sed 's#refs/tags/##' | sort -V | tail -n 1)
  if [[ -z "$latest_tag" ]]; then
    return 1
  fi

  current_tag=$(git -C "$OMADORA_ROOT" describe --tags "$(git -C "$OMADORA_ROOT" rev-list --tags --max-count=1)")
  if [[ -z "$current_tag" ]]; then
    return 1
  fi

  if [[ "$current_tag" != "$latest_tag" ]]; then
    omadora_update=1
  fi
}

update_collect_dnf() {
  if ! dnf5 -q --refresh makecache >/dev/null 2>&1; then
    with_errors=true
    return 1
  fi

  if ! dnf5 -q repoquery --upgrades \
    >"$OMADORA_UPDATE_DNF_UPGRADES_LIST" \
    2>/dev/null; then
    with_errors=true
    return 1
  fi

  dnf_package_total="$(
    wc -l <"$OMADORA_UPDATE_DNF_UPGRADES_LIST"
  )"

  if ! dnf5 -q advisory list --updates --json \
    >"$OMADORA_UPDATE_DNF_ADVISORIES_JSON" \
    2>/dev/null; then
    with_errors=true
    return 1
  fi

  dnf_advisory_total="$(
    jq 'length' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_security_total="$(
    jq '[.[] | select(.type == "security")] | length' \
      "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_bugfix_total="$(
    jq '[.[] | select(.type == "bugfix")] | length' \
      "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_enhancement_total="$(
    jq '[.[] | select(.type == "enhancement")] | length' \
      "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_other_total="$(
    jq '
      [
        .[]
        | select(
            .type != "security" and
            .type != "bugfix" and
            .type != "enhancement"
          )
      ]
      | length
    ' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"
}

update_collect_cargo() {

  if ! has_cmd cargo; then
    with_errors=true
    return 1
  fi

  if ! cargo install-update --version >/dev/null 2>&1; then
    with_errors=true
    return 1
  fi

  if ! cargo install-update --list \
    >"$OMADORA_UPDATE_CARGO_UPGRADES_LIST"; then
    with_errors=true
    return 1
  fi

  cargo_total="$(
    grep -cE '[[:space:]]Yes$' \
      "$OMADORA_UPDATE_CARGO_UPGRADES_LIST" ||
      true
  )"
}

update_collect_flatpak() {
  if ! has_cmd flatpak; then
    with_errors=true
    return 1
  fi

  if ! flatpak remote-ls \
    --updates \
    --columns=ref \
    2>/dev/null \
    >"$OMADORA_UPDATE_FLATPAK_UPGRADES_LIST"; then
    with_errors=true
    return 1
  fi

  flatpak_total="$(
    grep -cE '^[a-zA-Z0-9._-]+/.+/.+/.+$' \
      "$OMADORA_UPDATE_FLATPAK_UPGRADES_LIST" ||
      true
  )"
}

update_collect_firmware() {
  if ! has_cmd fwupdmgr; then
    return 0
  fi

  if ! fwupdmgr refresh \
    --force \
    >/dev/null 2>&1; then
    with_errors=true
    return 1
  fi

  if ! fwupdmgr get-updates \
    --json \
    >"$OMADORA_UPDATE_FWUPD_JSON" 2>/dev/null; then
    with_errors=true
    return 1
  fi

  firmware_total="$(
    jq '
      [
        .Devices[]?
        | select(has("Releases"))
      ]
      | length
    ' "$OMADORA_UPDATE_FWUPD_JSON"
  )"
}

update_write_state() {
  local total_updates

  total_updates=$((\
    omadora_update + \
    dnf_package_total + \
    flatpak_total + \
    cargo_total + \
    firmware_total))

  jq -n \
    --argjson with_errors "$with_errors" \
    --argjson omadora_update "${omadora_update}" \
    --argjson total_updates "$total_updates" \
    --argjson dnf_package_total "$dnf_package_total" \
    --argjson cargo_total "$cargo_total" \
    --argjson flatpak_total "$flatpak_total" \
    --argjson firmware_total "$firmware_total" \
    --argjson dnf_advisory_total "$dnf_advisory_total" \
    --argjson dnf_security_total "$dnf_security_total" \
    --argjson dnf_bugfix_total "$dnf_bugfix_total" \
    --argjson dnf_enhancement_total "$dnf_enhancement_total" \
    --argjson dnf_other_total "$dnf_other_total" \
    '
{
  schema_version: 1,

  meta: {
    timestamp:(now|floor),
    with_errors: $with_errors
  },

  updates: {
    total: $total_updates,

    omadora: {
      count: $omadora_update
    },

    dnf: {
      count: $dnf_package_total
    },

    cargo: {
      count: $cargo_total
    },

    flatpak: {
      count: $flatpak_total
    },

    firmware: {
      count: $firmware_total
    }
  },

  advisories: {
    dnf: {
      total: $dnf_advisory_total,
      security: $dnf_security_total,
      bugfix: $dnf_bugfix_total,
      enhancement: $dnf_enhancement_total,
      other: $dnf_other_total
    }
  }
}
' | write_atomic "$OMADORA_UPDATE_STATE_FILE"
}
