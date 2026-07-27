#!/usr/bin/env bash
set -euo pipefail

echo "Install SELinux support for socket-activated GNOME Keyring..."

sudo dnf install -y selinux-policy-devel
source "$OMADORA_PATH/install/login/selinux.sh"

echo "Enable socket-activated GNOME Keyring..."
systemctl --user enable gnome-keyring-daemon.socket

echo "GNOME Keyring socket activation will take effect after logout/login or reboot."
