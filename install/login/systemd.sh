# Ensure system boots to GUI-capable state
sudo systemctl set-default graphical.target

# Enable Omadora systemd units
systemctl --user enable omadora-session.target
systemctl --user enable omadora-recover-internal-monitor.service

# Let PAM unlock a user-manager-owned keyring daemon before a graphical session starts
systemctl --user enable gnome-keyring-daemon.socket
