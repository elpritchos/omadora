echo "Update Hyprland COPR repository"
sudo dnf copr remove solopasha/hyprland
sudo dnf copr enable -y sdegler/hyprland
sudo dnf upgrade -y

echo "Update configs for window rule changes"
omadora-refresh-config hypr/input.conf
omadora-refresh-config hypr/windows.conf
