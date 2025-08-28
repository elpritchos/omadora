#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eE

export PATH="$HOME/.local/share/omadora/bin:$PATH"
OMADORA_INSTALL=~/.local/share/omadora/install

# Sudo keep-alive
if ! sudo -n true 2>/dev/null; then
  sudo -v
fi
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Preparation
source $OMADORA_INSTALL/preflight/trap-errors.sh
source $OMADORA_INSTALL/preflight/guard.sh
source $OMADORA_INSTALL/preflight/chroot.sh
source $OMADORA_INSTALL/preflight/repositories.sh
source $OMADORA_INSTALL/preflight/migrations.sh

# Packaging
source $OMADORA_INSTALL/packages.sh
source $OMADORA_INSTALL/packaging/cargo.sh
source $OMADORA_INSTALL/packaging/fonts.sh

# Configuration
source $OMADORA_INSTALL/config/config.sh
source $OMADORA_INSTALL/config/theme.sh
source $OMADORA_INSTALL/config/branding.sh
source $OMADORA_INSTALL/config/gpg.sh
source $OMADORA_INSTALL/config/ssh-flakiness.sh
source $OMADORA_INSTALL/config/detect-keyboard-layout.sh
source $OMADORA_INSTALL/config/xcompose.sh
source $OMADORA_INSTALL/config/mise-ruby.sh
source $OMADORA_INSTALL/config/mimetypes.sh
source $OMADORA_INSTALL/config/localdb.sh
source $OMADORA_INSTALL/config/hardware/network.sh
source $OMADORA_INSTALL/config/hardware/fix-fkeys.sh
source $OMADORA_INSTALL/config/hardware/power.sh

# Login
source $OMADORA_INSTALL/login/plymouth.sh

# Reboot
clear
tte -i ~/.local/share/omadora/logo.txt --frame-rate 920 laseretch
echo
echo "You're done! So we're ready to reboot now..." | tte --frame-rate 640 wipe

sleep 5
reboot
