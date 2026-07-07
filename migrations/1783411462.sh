#!/usr/bin/env bash
set -euo pipefail

echo "Update web app desktop launchers to run through omadora-exec"

desktop_dir="$HOME/.local/share/applications"

if [[ ! -d $desktop_dir ]]; then
  exit 0
fi

while IFS= read -r -d '' desktop_file; do
  if grep -q '^Exec=\(omadora-launch-webapp\|omadora-webapp-handler\)\([[:space:]]\|$\)' "$desktop_file"; then
    sed -i 's/^Exec=\(omadora-launch-webapp\|omadora-webapp-handler\)\([[:space:]]\|$\)/Exec=omadora-exec \1\2/' "$desktop_file"
    echo "Updated $desktop_file"
  fi
done < <(find "$desktop_dir" -maxdepth 1 -type f -name '*.desktop' -print0)
