#!/usr/bin/env bash
set -euo pipefail

echo "Migrate default Flatpaks to system installation"

export OMADORA_PATH="${OMADORA_PATH:-$HOME/.local/share/omadora}"
export OMADORA_INSTALL="${OMADORA_INSTALL:-$OMADORA_PATH/install}"

default_flatpaks=(
  com.dec05eba.gpu_screen_recorder
  org.localsend.localsend_app
)

for app_id in "${default_flatpaks[@]}"; do
  if flatpak info --user "$app_id" >/dev/null 2>&1; then
    flatpak uninstall --user --noninteractive -y "$app_id"
  fi
done

if flatpak remotes --user --columns=name 2>/dev/null | grep -Fxq flathub; then
  flatpak remote-delete --user --force flathub
fi

source "$OMADORA_INSTALL/packaging/flatpak.sh"
