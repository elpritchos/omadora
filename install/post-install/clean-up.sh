# Remove unwanted groups
mapfile -t groups < <(grep -v '^#' "$OMADORA_INSTALL/omadora-removed.groups" | grep -v '^$')
sudo dnf group remove -y "${groups[@]}"

# Remove unwanted packages
mapfile -t packages < <(grep -v '^#' "$OMADORA_INSTALL/omadora-removed.packages" | grep -v '^$')
sudo dnf remove -y "${packages[@]}"

# Remove NetworkManager configuration
sudo rm -rf /etc/NetworkManager
