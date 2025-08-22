#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

OMADORA_PATH="$HOME/.local/share/omadora"
OMADORA_INSTALL="$OMADORA_PATH/install"

export PATH="$OMADORA_PATH/bin:$PATH"

# Give people a chance to retry running the installation
catch_errors() {
  echo -e "\n\e[31mOmadora installation failed!\e[0m"
  echo "You can retry by running: bash $OMADORA_PATH/install.sh"
}

trap catch_errors ERR

show_logo() {
  clear
  cat <$OMADORA_PATH/logo.txt
  echo
}

show_subtext() {
  echo "$1"
  echo
}

# Install prerequisites
source $OMADORA_INSTALL/preflight/guard.sh
source $OMADORA_INSTALL/preflight/presentation.sh
source $OMADORA_INSTALL/preflight/copr.sh
source $OMADORA_INSTALL/preflight/migrations.sh

# Configuration
show_logo
show_subtext "Installing base config [1/5]"
source $OMADORA_INSTALL/config/config.sh
source $OMADORA_INSTALL/config/detect-keyboard-layout.sh
source $OMADORA_INSTALL/config/network.sh
source $OMADORA_INSTALL/config/power.sh
source $OMADORA_INSTALL/config/login.sh

# Development
show_logo
show_subtext "Installing terminal tools [2/5]"
source $OMADORA_INSTALL/development/terminal.sh

# Desktop
show_logo
show_subtext "Installing desktop tools [3/5]"
source $OMADORA_INSTALL/desktop/desktop.sh
source $OMADORA_INSTALL/desktop/hyprland.sh
source $OMADORA_INSTALL/desktop/theme.sh
source $OMADORA_INSTALL/desktop/fonts.sh

# Apps
show_logo
show_subtext "Installing default applications [4/5]"
source $OMADORA_INSTALL/apps/apps.sh
source $OMADORA_INSTALL/apps/mimetypes.sh

# Updates
show_logo
show_subtext "Updating system packages [5/5]"
sudo updatedb
sudo dnf upgrade -y

# Reboot
show_logo
show_subtext "You're done! So we'll be rebooting now..."
sleep 2
reboot
