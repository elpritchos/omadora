#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eE

OMADORA_PATH="$HOME/.local/share/omadora"
OMADORA_INSTALL="$OMADORA_PATH/install"
export PATH="$OMADORA_PATH/bin:$PATH"

# Preparation
source $OMADORA_INSTALL/preflight/sudo-keep-alive.sh
source $OMADORA_INSTALL/preflight/trap-errors.sh
source $OMADORA_INSTALL/preflight/guard.sh
source $OMADORA_INSTALL/preflight/dnf.sh
source $OMADORA_INSTALL/preflight/migrations.sh

# Packaging
source $OMADORA_INSTALL/packages.sh
source $OMADORA_INSTALL/packaging/cargo.sh
source $OMADORA_INSTALL/packaging/fonts.sh
source $OMADORA_INSTALL/packaging/lazyvim.sh
source $OMADORA_INSTALL/packaging/icons.sh

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
source $OMADORA_INSTALL/config/hardware/network.sh
source $OMADORA_INSTALL/config/hardware/fix-fkeys.sh
source $OMADORA_INSTALL/config/hardware/power.sh

# Login
source $OMADORA_INSTALL/login/systemd.sh
source $OMADORA_INSTALL/login/plymouth.sh

# Finishing
source $OMADORA_INSTALL/reboot.sh
