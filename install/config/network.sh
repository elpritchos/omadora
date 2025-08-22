#!/bin/bash

# Install iwd explicitly for wifi if not set up during OS install
# TODO: Remove Network Manager etc. if installed, set iwd to use internal dhcp
if ! command -v iwctl &>/dev/null; then
  sudo dnf install -y iwd
  sudo systemctl enable --now iwd.service
fi

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
