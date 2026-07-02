# systemd-networkd-defaults provides the DHCP network profiles for wired and WiFi.
sudo systemctl enable systemd-networkd.service
sudo systemctl enable iwd.service

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
