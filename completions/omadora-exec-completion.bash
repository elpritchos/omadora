OMADORA_ROOT="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.." &&
    pwd
)"

_omadora_exec_completion() {
  local cur="${COMP_WORDS[COMP_CWORD]:-}"

  COMPREPLY=()

  if ((COMP_CWORD == 1)); then
    mapfile -t COMPREPLY < <("$OMADORA_ROOT/bin/omadora-exec" __complete "$cur" 2>/dev/null)
  fi
}

complete -F _omadora_exec_completion omadora-exec
