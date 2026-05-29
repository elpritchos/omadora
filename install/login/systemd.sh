# Ensure system boots to GUI-capable state
sudo systemctl set-default graphical.target

# Enable third-party user services
systemctl --user enable --now \
  hyprpolkitagent.service \
  hypridle.service \
  hyprpaper.service \
  waybar.service

# Enable omadora-session target
systemctl --user enable omadora-session.target

# Enable omadora-session services
systemctl --user enable \
  omadora-battery.timer \
  omadora-update-check.timer \
  omadora-fcitx5.service \
  omadora-mako.service \
  omadora-theme.path

# Start omadora-session target
systemctl --user start omadora-session.target
