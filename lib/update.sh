readonly OMADORA_UPDATE_STATE_DIR="${OMADORA_STATE_HOME}/update"
readonly OMADORA_UPDATE_CACHE_DIR="${OMADORA_CACHE_HOME}/update"

readonly OMADORA_UPDATE_LOCK_FILE="${OMADORA_RUNTIME_DIR}/update.lock"

readonly OMADORA_UPDATE_STATE_FILE="$OMADORA_UPDATE_STATE_DIR/state.json"

readonly OMADORA_UPDATE_DNF_UPGRADES_LIST="$OMADORA_UPDATE_CACHE_DIR/dnf-upgrades.txt"
readonly OMADORA_UPDATE_DNF_ADVISORIES_JSON="$OMADORA_UPDATE_CACHE_DIR/dnf-advisories.json"
readonly OMADORA_UPDATE_FWUPD_JSON="$OMADORA_UPDATE_CACHE_DIR/fwupd.json"

update_waybar_module() {
  pkill -RTMIN+7 waybar || true
}

update_init() {
  mkdir -p \
    "$OMADORA_UPDATE_STATE_DIR" \
    "$OMADORA_UPDATE_CACHE_DIR" \
    "$OMADORA_RUNTIME_DIR"
}

update_write_json_atomic() {
  local target="$1"
  local tmp

  tmp="$(mktemp "${target}.tmp.XXXXXX")"

  cat >"$tmp"

  mv "$tmp" "$target"
}

update_collect_dnf() {
  dnf_package_total=0

  dnf5 repoquery \
    --upgrades \
    >"$OMADORA_UPDATE_DNF_UPGRADES_LIST" 2>/dev/null ||
    return 1

  dnf_package_total="$(
    wc -l <"$OMADORA_UPDATE_DNF_UPGRADES_LIST"
  )"
}

update_collect_advisories() {
  dnf_advisory_total=0
  dnf_security_total=0
  dnf_bugfix_total=0
  dnf_enhancement_total=0
  dnf_other_total=0

  dnf5 advisory list \
    --updates \
    --json \
    >"$OMADORA_UPDATE_DNF_ADVISORIES_JSON" 2>/dev/null ||
    return 1

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

update_collect_flatpak() {
  flatpak_total=0

  command -v flatpak >/dev/null 2>&1 ||
    return 0

  flatpak_total="$(
    flatpak remote-ls \
      --updates \
      --columns=ref \
      2>/dev/null |
      grep -cE '^[a-zA-Z0-9._-]+/.+/.+/.+' || true
  )"
}

update_collect_cargo() {
  cargo_total=0

  command -v cargo >/dev/null 2>&1 ||
    return 0

  cargo install-update --version >/dev/null 2>&1 ||
    return 0

  cargo_total="$(
    cargo install-update --list |
      grep -cE '[[:space:]]Yes$' || true
  )"
}

update_collect_firmware() {
  firmware_total=0

  command -v fwupdmgr >/dev/null 2>&1 ||
    return 0

  fwupdmgr get-updates \
    --json \
    >"$OMADORA_UPDATE_FWUPD_JSON" 2>/dev/null ||
    return 1

  firmware_total="$(
    jq '
      [
        .Devices[]?
        | select(
            .Updates != null and
            (.Updates | length > 0)
          )
      ]
      | length
    ' "$OMADORA_UPDATE_FWUPD_JSON"
  )"
}

update_write_state() {
  local timestamp
  local total_updates

  timestamp="$(date +%s)"

  : "${dnf_package_total:=0}"
  : "${flatpak_total:=0}"
  : "${cargo_total:=0}"
  : "${firmware_total:=0}"

  : "${dnf_advisory_total:=0}"
  : "${dnf_security_total:=0}"
  : "${dnf_bugfix_total:=0}"
  : "${dnf_enhancement_total:=0}"
  : "${dnf_other_total:=0}"

  total_updates=$((\
    dnf_package_total + \
    flatpak_total + \
    cargo_total + \
    firmware_total))

  jq -n \
    --argjson timestamp "$timestamp" \
    --argjson total_updates "$total_updates" \
    --argjson dnf_package_total "$dnf_package_total" \
    --argjson flatpak_total "$flatpak_total" \
    --argjson cargo_total "$cargo_total" \
    --argjson firmware_total "$firmware_total" \
    --argjson dnf_advisory_total "$dnf_advisory_total" \
    --argjson dnf_security_total "$dnf_security_total" \
    --argjson dnf_bugfix_total "$dnf_bugfix_total" \
    --argjson dnf_enhancement_total "$dnf_enhancement_total" \
    --argjson dnf_other_total "$dnf_other_total" \
    '
{
  schema_version: 1,

  timestamp: $timestamp,

  updates: {
    total: $total_updates,

    dnf: {
      count: $dnf_package_total
    },

    flatpak: {
      count: $flatpak_total
    },

    cargo: {
      count: $cargo_total
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
' | update_write_json_atomic "$OMADORA_UPDATE_STATE_FILE"
}
