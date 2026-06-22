OMADORA_ROOT="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.." &&
    pwd
)"
OMADORA_LIBEXEC_DIR="$OMADORA_ROOT/libexec"

_omactl_completion() {
  local cur cmd

  cur="${COMP_WORDS[COMP_CWORD]}"
  cmd="${COMP_WORDS[1]:-}"

  [[ -d "$OMADORA_LIBEXEC_DIR" ]] || return

  # ----------------------------------------
  # Top-level completion
  # ----------------------------------------

  if [[ "$COMP_CWORD" -eq 1 ]]; then
    local -a subcmds=()
    local f

    for f in "$OMADORA_LIBEXEC_DIR"/omactl-*; do
      [[ -x "$f" ]] || continue
      subcmds+=("${f##*/omactl-}")
    done

    mapfile -t COMPREPLY < <(
      compgen -W "$(printf '%s\n' "${subcmds[@]}")" -- "$cur"
    )

    return
  fi

  # ----------------------------------------
  # Delegate to subcommand
  # ----------------------------------------

  local subcommand="$OMADORA_LIBEXEC_DIR/omactl-$cmd"

  if [[ -x "$subcommand" ]]; then
    mapfile -t COMPREPLY < <(
      "$subcommand" __complete "${COMP_WORDS[@]:2}" 2>/dev/null
    )
  fi
}

complete -F _omactl_completion omactl
