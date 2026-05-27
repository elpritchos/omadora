_omactl_completion() {
  local cur cmd root libexec

  cur="${COMP_WORDS[COMP_CWORD]}"
  cmd="${COMP_WORDS[1]:-}"

  root="${OMADORA_PATH:-$HOME/.local/share/omadora}"
  libexec="$root/libexec"

  [[ -d "$libexec" ]] || return

  # ----------------------------------------
  # Top-level completion
  # ----------------------------------------

  if [[ "$COMP_CWORD" -eq 1 ]]; then
    local -a subcmds=()
    local f

    for f in "$libexec"/omactl-*; do
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

  local subcommand="$libexec/omactl-$cmd"

  if [[ -x "$subcommand" ]]; then
    mapfile -t COMPREPLY < <(
      "$subcommand" __complete "${COMP_WORDS[@]:2}" 2>/dev/null
    )
  fi
}

complete -F _omactl_completion omactl
