#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define paths
export OMADORA_PATH="$HOME/.local/share/omadora"
export OMADORA_INSTALL="$OMADORA_PATH/install"
export PATH="$OMADORA_PATH/bin:$PATH"

# Install
source "$OMADORA_INSTALL/preflight/all.sh"
source "$OMADORA_INSTALL/packaging/all.sh"
source "$OMADORA_INSTALL/config/all.sh"
source "$OMADORA_INSTALL/login/all.sh"
source "$OMADORA_INSTALL/post-install/all.sh"
