# Ensure system boots to GUI-capable state
sudo systemctl set-default graphical.target

# Enable the internal monitor recovery service
systemctl --user enable omadora-recover-internal-monitor.service
