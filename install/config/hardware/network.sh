#!/bin/bash

# Ensure networkd handles wired and wifi dhcp
sudo tee /etc/systemd/network/20-wired.network >/dev/null <<'EOF'
[Match]
Name=en*

[Network]
DHCP=yes
EOF
sudo tee /etc/systemd/network/25-wifi.network >/dev/null <<'EOF'
[Match]
Name=wlan*

[Network]
DHCP=yes
EOF

# Ensure network services enabled
sudo systemctl enable systemd-networkd.service
sudo systemctl enable iwd.service

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
