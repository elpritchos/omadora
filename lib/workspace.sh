workspace_windows_close_all() {
  local -a windows=()

  mapfile -t windows < <(
    hyprctl clients -j |
      jq -r '.[] | select(.mapped == true) | .address'
  )

  ((${#windows[@]} == 0)) && return

  for window in "${windows[@]}"; do
    hyprctl dispatch closewindow "address:${window}"
  done
}

workspace_reset() {
  hyprctl dispatch workspace 1
}
