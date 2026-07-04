#!/bin/bash

set -e

# Set install mode to online since boot.sh is used for curl installations
export OMADORA_ONLINE_INSTALL=true

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

echo "Installing git to clone the Omadora repo..."
sudo dnf install -y git

# Use custom repo if specified, otherwise default
OMADORA_REPO="${OMADORA_REPO:-elpritchos/omadora}"

echo -e "\nCloning Omadora from: https://github.com/${OMADORA_REPO}.git"
rm -rf ~/.local/share/omadora/
git clone "https://github.com/${OMADORA_REPO}.git" ~/.local/share/omadora >/dev/null

# Use custom branch if instructed, otherwise default to master
OMADORA_REF="${OMADORA_REF:-master}"
if [[ $OMADORA_REF != "master" ]]; then
  echo -e "\e[32mUsing branch: $OMADORA_REF\e[0m"
  cd ~/.local/share/omadora
  git fetch origin "${OMADORA_REF}" && git checkout "${OMADORA_REF}"
  cd -
fi

echo -e "\nInstallation starting..."
source ~/.local/share/omadora/install.sh
