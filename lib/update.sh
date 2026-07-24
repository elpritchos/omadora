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
omadora_current_version=""
omadora_latest_version=""
omadora_status="ok"
dnf_package_total=0
dnf_advisory_total=0
dnf_security_total=0
dnf_security_critical_total=0
dnf_security_important_total=0
dnf_bugfix_total=0
dnf_enhancement_total=0
dnf_other_total=0
dnf_status="ok"
cargo_total=0
cargo_status="ok"
flatpak_total=0
flatpak_status="ok"
firmware_total=0
firmware_status="ok"
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
  omadora_latest_version="$(
    git -C "$OMADORA_ROOT" ls-remote --tags origin |
      grep -v "{}" |
      awk '{print $2}' |
      sed 's#refs/tags/##' |
      sort -V |
      tail -n 1
  )"
  if [[ -z "$omadora_latest_version" ]]; then
    omadora_status="error"
    with_errors=true
    return 1
  fi

  omadora_current_version="$(
    git -C "$OMADORA_ROOT" describe --tags \
      "$(git -C "$OMADORA_ROOT" rev-list --tags --max-count=1)"
  )"
  if [[ -z "$omadora_current_version" ]]; then
    omadora_status="error"
    with_errors=true
    return 1
  fi

  if [[ "$omadora_current_version" != "$omadora_latest_version" ]]; then
    omadora_update=1
  fi
}

update_collect_dnf() {
  if ! dnf5 -q --refresh makecache >/dev/null 2>&1; then
    dnf_status="error"
    with_errors=true
    return 1
  fi

  if ! dnf5 -q repoquery --upgrades --queryformat '%{name}\n' |
    sort -u \
    >"$OMADORA_UPDATE_DNF_UPGRADES_LIST" \
    2>/dev/null; then
    dnf_status="error"
    with_errors=true
    return 1
  fi

  dnf_package_total="$(
    grep -cve '^[[:space:]]*$' "$OMADORA_UPDATE_DNF_UPGRADES_LIST" ||
      true
  )"

  if ! dnf5 -q advisory info --updates --json \
    >"$OMADORA_UPDATE_DNF_ADVISORIES_JSON" \
    2>/dev/null; then
    dnf_status="error"
    with_errors=true
    return 1
  fi

  dnf_advisory_total="$(
    jq '[unique_by(.Name)[]] | length' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_security_total="$(
    jq '[unique_by(.Name)[] | select((.Type | ascii_downcase) == "security")] | length' \
      "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_security_critical_total="$(
    jq '
      [
        unique_by(.Name)[]
        | select(
            (.Type | ascii_downcase) == "security"
            and (.Severity | ascii_downcase) == "critical"
          )
      ]
      | length
    ' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_security_important_total="$(
    jq '
      [
        unique_by(.Name)[]
        | select(
            (.Type | ascii_downcase) == "security"
            and (.Severity | ascii_downcase) == "important"
          )
      ]
      | length
    ' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_bugfix_total="$(
    jq '[unique_by(.Name)[] | select((.Type | ascii_downcase) == "bugfix")] | length' \
      "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_enhancement_total="$(
    jq '[unique_by(.Name)[] | select((.Type | ascii_downcase) == "enhancement")] | length' \
      "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"

  dnf_other_total="$(
    jq '
      [
        unique_by(.Name)[]
        | select(
            (.Type | ascii_downcase) != "security" and
            (.Type | ascii_downcase) != "bugfix" and
            (.Type | ascii_downcase) != "enhancement"
          )
      ]
      | length
    ' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON"
  )"
}

update_collect_cargo() {
  if ! has_cmd cargo; then
    cargo_status="error"
    with_errors=true
    return 1
  fi

  if ! cargo install-update --version >/dev/null 2>&1; then
    cargo_status="error"
    with_errors=true
    return 1
  fi

  if ! cargo install-update --list \
    >"$OMADORA_UPDATE_CARGO_UPGRADES_LIST"; then
    cargo_status="error"
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
    flatpak_status="error"
    with_errors=true
    return 1
  fi

  if ! output="$(printf 'n\n' | LC_ALL=C flatpak update 2>&1)"; then
    if ! grep -Eq '^[[:space:]]*[0-9]+[.)][[:space:]]' <<<"$output"; then
      flatpak_status="error"
      with_errors=true
      return 1
    fi
  fi

  awk '
    /^[[:space:]]*[0-9]+[.)][[:space:]]/ {
      line = $0
      sub(/^[[:space:]]*[0-9]+[.)][[:space:]]*/, "", line)
      sub(/^\[[^]]+\][[:space:]]*/, "", line)
      sub(/[[:space:]].*$/, "", line)
      print line
    }
  ' <<<"$output" >"$OMADORA_UPDATE_FLATPAK_UPGRADES_LIST"

  flatpak_total="$(
    grep -cve '^[[:space:]]*$' "$OMADORA_UPDATE_FLATPAK_UPGRADES_LIST" ||
      true
  )"
}

update_collect_firmware() {
  if ! has_cmd fwupdmgr; then
    firmware_status="unavailable"
    return 0
  fi

  if ! fwupdmgr refresh \
    --force \
    >/dev/null 2>&1; then
    firmware_status="error"
    with_errors=true
    return 1
  fi

  if ! fwupdmgr get-updates \
    --json \
    >"$OMADORA_UPDATE_FWUPD_JSON" 2>/dev/null; then
    firmware_status="error"
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
  local cargo_items
  local dnf_advisories
  local dnf_items
  local firmware_items
  local flatpak_items
  local total_updates

  dnf_items="$(
    jq -Rsc 'split("\n") | map(select(length > 0))' \
      "$OMADORA_UPDATE_DNF_UPGRADES_LIST" 2>/dev/null ||
      printf '[]'
  )"
  flatpak_items="$(
    jq -Rsc 'split("\n") | map(select(length > 0)) | unique' \
      "$OMADORA_UPDATE_FLATPAK_UPGRADES_LIST" 2>/dev/null ||
      printf '[]'
  )"
  cargo_items="$(
    awk '$NF == "Yes" { print $1 }' \
      "$OMADORA_UPDATE_CARGO_UPGRADES_LIST" 2>/dev/null |
      jq -Rsc 'split("\n") | map(select(length > 0)) | unique'
  )"
  firmware_items="$(
    jq '
      [
        .Devices[]?
        | select(has("Releases"))
        | (.Name // .DeviceId // "Firmware update")
      ]
      | unique
    ' "$OMADORA_UPDATE_FWUPD_JSON" 2>/dev/null ||
      printf '[]'
  )"
  dnf_advisories="$(
    jq '
      [
        unique_by(.Name)[]
        | {
            id: .Name,
            title: .Title,
            type: (.Type | ascii_downcase),
            severity: .Severity
          }
      ]
    ' "$OMADORA_UPDATE_DNF_ADVISORIES_JSON" 2>/dev/null ||
      printf '[]'
  )"

  total_updates=$((\
    omadora_update + \
    dnf_package_total + \
    flatpak_total + \
    cargo_total + \
    firmware_total))

  jq -n \
    --argjson with_errors "$with_errors" \
    --argjson omadora_update "${omadora_update}" \
    --arg omadora_current_version "$omadora_current_version" \
    --arg omadora_latest_version "$omadora_latest_version" \
    --arg omadora_status "$omadora_status" \
    --argjson total_updates "$total_updates" \
    --argjson dnf_package_total "$dnf_package_total" \
    --argjson dnf_items "$dnf_items" \
    --arg dnf_status "$dnf_status" \
    --argjson cargo_total "$cargo_total" \
    --argjson cargo_items "$cargo_items" \
    --arg cargo_status "$cargo_status" \
    --argjson flatpak_total "$flatpak_total" \
    --argjson flatpak_items "$flatpak_items" \
    --arg flatpak_status "$flatpak_status" \
    --argjson firmware_total "$firmware_total" \
    --argjson firmware_items "$firmware_items" \
    --arg firmware_status "$firmware_status" \
    --argjson dnf_advisory_total "$dnf_advisory_total" \
    --argjson dnf_security_total "$dnf_security_total" \
    --argjson dnf_security_critical_total "$dnf_security_critical_total" \
    --argjson dnf_security_important_total "$dnf_security_important_total" \
    --argjson dnf_bugfix_total "$dnf_bugfix_total" \
    --argjson dnf_enhancement_total "$dnf_enhancement_total" \
    --argjson dnf_other_total "$dnf_other_total" \
    --argjson dnf_advisories "$dnf_advisories" \
    '
{
  schema_version: 2,

  meta: {
    timestamp:(now|floor),
    with_errors: $with_errors
  },

  updates: {
    total: $total_updates,

    omadora: {
      count: $omadora_update,
      status: $omadora_status,
      current_version: $omadora_current_version,
      latest_version: $omadora_latest_version
    },

    dnf: {
      count: $dnf_package_total,
      status: $dnf_status,
      items:(if $dnf_package_total > 0 then $dnf_items else [] end)
    },

    cargo: {
      count: $cargo_total,
      status: $cargo_status,
      items:(if $cargo_total > 0 then $cargo_items else [] end)
    },

    flatpak: {
      count: $flatpak_total,
      status: $flatpak_status,
      items:(if $flatpak_total > 0 then $flatpak_items else [] end)
    },

    firmware: {
      count: $firmware_total,
      status: $firmware_status,
      items:(if $firmware_total > 0 then $firmware_items else [] end)
    }
  },

  advisories: {
    dnf: {
      total: $dnf_advisory_total,
      security: $dnf_security_total,
      security_critical: $dnf_security_critical_total,
      security_important: $dnf_security_important_total,
      bugfix: $dnf_bugfix_total,
      enhancement: $dnf_enhancement_total,
      other: $dnf_other_total,
      items:(if $dnf_advisory_total > 0 then $dnf_advisories else [] end)
    }
  }
}
' | write_atomic "$OMADORA_UPDATE_STATE_FILE"
}
