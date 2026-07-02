# shellcheck shell=bash

cli_group_name() {
  local file="$1"

  printf '%s\n' "${file##*/omactl-}"
}

cli_group_files() {
  local file

  for file in "$OMADORA_LIBEXEC_DIR"/omactl/omactl-*; do
    [[ -x "$file" ]] || continue
    printf '%s\n' "$file"
  done | sort
}

cli_group_summary() {
  local group="$1"
  local script="$OMADORA_LIBEXEC_DIR/omactl/omactl-$group"
  local summary

  if [[ -x "$script" ]]; then
    summary="$("$script" __summary 2>/dev/null || true)"
    [[ -n "$summary" ]] && printf '%s\n' "$summary"
  fi

  return 0
}

cli_root_usage() {
  local file group summary

  cat <<'EOF'
Usage:
  omactl <command>

Commands:
EOF

  while IFS= read -r file; do
    group="$(cli_group_name "$file")"
    summary="$(cli_group_summary "$group")"
    printf '  %-16s %s\n' "$group" "$summary"
  done < <(cli_group_files)

  printf '\n'
}

cli_root_complete() {
  local cur="${1:-}"
  local file group groups=""

  while IFS= read -r file; do
    group="$(cli_group_name "$file")"
    groups="${groups:+$groups }$group"
  done < <(cli_group_files)

  compgen -W "$groups" -- "$cur"
}

cli_root_main() {
  local command="${1:-}"
  local script

  case "$command" in
  "" | -h | --help | help)
    cli_root_usage
    ;;

  __complete)
    shift
    local cur="${1:-}"
    shift || true

    if (($# == 0)); then
      cli_root_complete "$cur"
      return
    fi

    command="$1"
    shift
    script="$OMADORA_LIBEXEC_DIR/omactl/omactl-$command"
    [[ -x "$script" ]] && "$script" __complete "$cur" "$@" 2>/dev/null
    ;;

  *)
    shift
    script="$OMADORA_LIBEXEC_DIR/omactl/omactl-$command"

    if [[ ! -x "$script" ]]; then
      cli_root_usage >&2
      die "unknown command: $command"
    fi

    exec "$script" "$@"
    ;;
  esac
}

cli_command_path() {
  local entry="$1"
  local path

  IFS='|' read -r path _ _ _ _ _ <<<"$entry"
  printf '%s\n' "$path"
}

cli_command_args() {
  local entry="$1"
  local args

  IFS='|' read -r _ args _ _ _ _ <<<"$entry"
  printf '%s\n' "$args"
}

cli_command_summary() {
  local entry="$1"
  local summary

  IFS='|' read -r _ _ summary _ _ _ <<<"$entry"
  printf '%s\n' "$summary"
}

cli_command_handler() {
  local entry="$1"
  local handler

  IFS='|' read -r _ _ _ handler _ _ <<<"$entry"
  printf '%s\n' "$handler"
}

cli_namespace_exists() {
  local wanted="$1"
  local entry namespace

  for entry in "${CLI_NAMESPACES[@]:-}"; do
    IFS='|' read -r namespace _ <<<"$entry"
    [[ "$namespace" == "$wanted" ]] && return 0
  done

  return 1
}

cli_path_depth() {
  local path="$1"
  local -a parts

  [[ -n "$path" ]] || {
    printf '0\n'
    return
  }

  read -r -a parts <<<"$path"
  printf '%s\n' "${#parts[@]}"
}

cli_relative_path() {
  local path="$1"
  local prefix="$2"

  if [[ -z "$prefix" ]]; then
    printf '%s\n' "$path"
  elif [[ "$path" == "$prefix" ]]; then
    printf '\n'
  elif [[ "$path" == "$prefix "* ]]; then
    printf '%s\n' "${path#"$prefix "}"
  else
    return 1
  fi
}

cli_command_completer() {
  local entry="$1"
  local completer

  IFS='|' read -r _ _ _ _ completer _ <<<"$entry"
  printf '%s\n' "$completer"
}

cli_command_compopts() {
  local entry="$1"
  local compopts

  IFS='|' read -r _ _ _ _ _ compopts <<<"$entry"
  printf '%s\n' "$compopts"
}

cli_complete_lines() {
  local cur="${1:-}"
  local candidate

  while IFS= read -r candidate; do
    [[ "$candidate" == "$cur"* ]] && printf '%s\n' "$candidate"
  done
}

cli_children() {
  local prefix="${1:-}"
  local include_nested="${2:-false}"
  local entry path rel child seen children=()

  for entry in "${CLI_NAMESPACES[@]:-}"; do
    IFS='|' read -r path _ <<<"$entry"
    rel="$(cli_relative_path "$path" "$prefix")" || continue
    [[ -n "$rel" ]] || continue
    if [[ "$include_nested" == "true" ]]; then
      child="${rel%% *}"
    else
      [[ "$rel" != *" "* ]] || continue
      child="$rel"
    fi
    seen=" ${children[*]} "
    [[ "$seen" == *" $child "* ]] && continue
    children+=("$child")
    printf '%s\n' "$child"
  done

  for entry in "${CLI_COMMANDS[@]}"; do
    path="$(cli_command_path "$entry")"
    rel="$(cli_relative_path "$path" "$prefix")" || continue
    [[ -n "$rel" ]] || continue
    if [[ "$include_nested" == "true" ]]; then
      child="${rel%% *}"
    else
      [[ "$rel" != *" "* ]] || continue
      child="$rel"
    fi
    seen=" ${children[*]} "
    [[ "$seen" == *" $child "* ]] && continue
    children+=("$child")
    printf '%s\n' "$child"
  done
}

cli_usage() {
  local prefix="${1:-}"
  local entry path args summary child command rel

  printf 'Usage:\n'
  printf '  omactl %s' "$CLI_GROUP"
  [[ -n "$prefix" ]] && printf ' %s' "$prefix"
  printf ' <command>\n\n'
  printf 'Commands:\n'

  while IFS= read -r child; do
    for entry in "${CLI_NAMESPACES[@]:-}"; do
      IFS='|' read -r path summary <<<"$entry"
      rel="$(cli_relative_path "$path" "$prefix")" || continue
      [[ "$rel" == "$child" ]] || continue
      printf '  %-28s %s\n' "$child" "$summary"
      break
    done

    for entry in "${CLI_COMMANDS[@]}"; do
      path="$(cli_command_path "$entry")"
      rel="$(cli_relative_path "$path" "$prefix")" || continue
      [[ "$rel" == "$child" ]] || continue
      args="$(cli_command_args "$entry")"
      summary="$(cli_command_summary "$entry")"
      command="$child"
      [[ -n "$args" ]] && command="$command $args"
      printf '  %-28s %s\n' "$command" "$summary"
      break
    done
  done < <(cli_children "$prefix" false)

  printf '\n'
}

cli_command_usage() {
  local entry="$1"
  local path args summary

  path="$(cli_command_path "$entry")"
  args="$(cli_command_args "$entry")"
  summary="$(cli_command_summary "$entry")"

  printf 'Usage:\n'
  printf '  omactl %s %s' "$CLI_GROUP" "$path"
  [[ -n "$args" ]] && printf ' %s' "$args"
  printf '\n'

  if [[ -n "$summary" ]]; then
    printf '\n%s\n' "$summary"
  fi
}

cli_find_command() {
  local argc="$1"
  shift
  local words=("$@")
  local entry path depth i match

  for ((i = argc; i > 0; i--)); do
    match="${words[*]:0:i}"
    for entry in "${CLI_COMMANDS[@]}"; do
      path="$(cli_command_path "$entry")"
      depth="$(cli_path_depth "$path")"
      [[ "$depth" -eq "$i" && "$path" == "$match" ]] || continue
      printf '%s\n' "$entry"
      return
    done
  done

  return 1
}

cli_complete_children() {
  local prefix="$1"
  local cur="$2"

  cli_children "$prefix" true | cli_complete_lines "$cur"
}

cli_complete_options() {
  local compopts="$1"
  local option

  for option in $compopts; do
    printf '__omactl_compopt:%s\n' "$option"
  done
}

cli_complete() {
  local cur="${1:-}"
  shift || true
  local words=("$@")
  local argc="${#words[@]}"
  local prefix="" entry completer compopts depth

  if ((argc == 0)); then
    cli_complete_children "" "$cur"
    return
  fi

  if entry="$(cli_find_command "$argc" "${words[@]}")"; then
    compopts="$(cli_command_compopts "$entry")"
    [[ -n "$compopts" ]] && cli_complete_options "$compopts"

    completer="$(cli_command_completer "$entry")"
    if [[ -n "$completer" ]] && declare -F "$completer" >/dev/null; then
      depth="$(cli_path_depth "$(cli_command_path "$entry")")"
      "$completer" "$cur" "${words[@]:depth}"
    fi
    return
  fi

  prefix="${words[*]}"
  cli_complete_children "$prefix" "$cur"
}

cli_main() {
  local command="${1:-}"
  local words entry handler depth last_index prefix

  case "$command" in
  __summary)
    printf '%s\n' "${CLI_SUMMARY:-}"
    ;;

  "")
    if [[ -n "${CLI_DEFAULT_COMMAND:-}" ]]; then
      read -r -a words <<<"$CLI_DEFAULT_COMMAND"

      if ! entry="$(cli_find_command "${#words[@]}" "${words[@]}")"; then
        die "default command not found: $CLI_DEFAULT_COMMAND"
      fi

      handler="$(cli_command_handler "$entry")"
      if ! declare -F "$handler" >/dev/null; then
        die "handler not found: $handler"
      fi

      "$handler"
      return
    fi

    cli_usage
    ;;

  -h | --help | help)
    cli_usage
    ;;

  __complete)
    shift
    cli_complete "$@"
    ;;

  *)
    words=("$@")
    last_index="$((${#words[@]} - 1))"

    if [[ "${words[$last_index]}" == "-h" || "${words[$last_index]}" == "--help" || "${words[$last_index]}" == "help" ]]; then
      unset "words[$last_index]"
      prefix="${words[*]}"

      if entry="$(cli_find_command "${#words[@]}" "${words[@]}")"; then
        cli_command_usage "$entry"
        return
      fi

      if [[ -z "$prefix" ]] || cli_namespace_exists "$prefix"; then
        cli_usage "$prefix"
        return
      fi

      cli_usage >&2
      die "unknown command: $prefix"
    fi

    if ! entry="$(cli_find_command "${#words[@]}" "${words[@]}")"; then
      prefix="${words[*]}"
      if cli_namespace_exists "$prefix"; then
        cli_usage "$prefix"
        return
      fi

      cli_usage >&2
      die "unknown command: ${words[*]}"
    fi

    handler="$(cli_command_handler "$entry")"
    if ! declare -F "$handler" >/dev/null; then
      die "handler not found: $handler"
    fi

    depth="$(cli_path_depth "$(cli_command_path "$entry")")"
    "$handler" "${words[@]:depth}"
    ;;
  esac
}
