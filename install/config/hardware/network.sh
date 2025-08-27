#!/bin/bash

# Ensure iwd service with dhcp enabled
sudo tee /etc/iwd/main.conf >/dev/null <<'EOF'
[General]
EnableNetworkConfiguration=true

[Network]
EnableIPv6=true
EOF
chrootable_systemctl_enable iwd.service

# Ensure networkd handles wired connections
sudo tee /etc/systemd/network/20-wired.network >/dev/null <<'EOF'
[Match]
Name=en*

[Network]
DHCP=yes
EOF
chrootable_systemctl_enable systemd-networkd

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
