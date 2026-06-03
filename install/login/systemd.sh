# Ensure system boots to GUI-capable state
sudo systemctl set-default graphical.target

# Enable omadora-session target
systemctl --user enable omadora-session.target
