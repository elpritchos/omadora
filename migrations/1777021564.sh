echo "Update Hyprland COPR repository"
sudo dnf copr remove sdegler/hyprland
sudo dnf copr enable -y lionheartp/Hyprland
sudo dnf upgrade -y
