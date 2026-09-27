#!/usr/bin/env bash
set -euo pipefail

current_theme="$("$OMADORA_PATH/libexec/omadora-theme-current" 2>/dev/null || true)"

if [[ -n $current_theme ]] &&
  "$OMADORA_PATH/libexec/omadora-theme-list" | grep -qxF "$current_theme" &&
  "$OMADORA_PATH/libexec/omadora-theme-set" "$current_theme"; then
  echo "Reapplied current theme: $current_theme"
else
  if [[ -n $current_theme ]]; then
    echo "Warning: failed to reapply current theme '$current_theme'. Falling back to Rose Pine Darker." >&2
  fi

  "$OMADORA_PATH/libexec/omadora-theme-set" "Rose Pine Darker" ||
    echo "Warning: failed to apply fallback theme 'Rose Pine Darker'." >&2
fi
