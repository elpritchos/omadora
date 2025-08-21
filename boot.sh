#!/bin/bash

ansi_art='
▄██████▄    ▄▄▄▄███▄▄▄▄      ▄████████ ████████▄   ▄██████▄     ▄████████    ▄████████
███    ███ ▄██▀▀▀███▀▀▀██▄   ███    ███ ███   ▀███ ███    ███   ███    ███   ███    ███
███    ███ ███   ███   ███   ███    ███ ███    ███ ███    ███   ███    ███   ███    ███
███    ███ ███   ███   ███   ███    ███ ███    ███ ███    ███  ▄███▄▄▄▄██▀   ███    ███
███    ███ ███   ███   ███ ▀███████████ ███    ███ ███    ███ ▀▀███▀▀▀▀▀   ▀███████████
███    ███ ███   ███   ███   ███    ███ ███    ███ ███    ███ ▀███████████   ███    ███
███    ███ ███   ███   ███   ███    ███ ███   ▄███ ███    ███   ███    ███   ███    ███
 ▀██████▀   ▀█   ███   █▀    ███    █▀  ████████▀   ▀██████▀    ███    ███   ███    █▀
                                                                ███    ███'

clear
echo -e "\n$ansi_art\n"

sudo dnf install -y git

# Use custom repo if specified, otherwise default
OMADORA_REPO="${OMADORA_REPO:-elpritchos/omadora}"

echo -e "\nCloning Omadora from: https://github.com/${OMADORA_REPO}.git"
rm -rf ~/.local/share/omadora/
git clone "https://github.com/${OMADORA_REPO}.git" ~/.local/share/omadora >/dev/null

# Use custom branch if instructed
if [[ -n "$OMADORA_REF" ]]; then
  echo -e "\eUsing branch: $OMADORA_REF"
  cd ~/.local/share/omadora
  git fetch origin "${OMADORA_REF}" && git checkout "${OMADORA_REF}"
  cd -
fi

echo -e "\nInstallation starting..."
source ~/.local/share/omadora/install.sh
