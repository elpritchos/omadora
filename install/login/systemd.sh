# Ensure system boots to GUI-capable state
sudo systemctl set-default graphical.target

# Enable Omadora systemd units
systemctl --user enable omadora-session.target

systemctl --user enable omadora-battery-monitor.timer
systemctl --user enable omadora-update-check.timer
systemctl --user enable omadora-weather-check.timer

systemctl --user enable omadora-fcitx5.service
systemctl --user enable omadora-hyprland-monitor.service
systemctl --user enable omadora-polkitagent.service
systemctl --user enable omadora-recover-internal-monitor.service
systemctl --user enable omadora-session.service

systemctl --user enable hypridle.service
systemctl --user enable hyprpaper.service
systemctl --user enable hyprsunset.service
systemctl --user enable mako.service
systemctl --user enable waybar.service
