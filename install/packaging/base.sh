# Install base groups
mapfile -t groups < <(grep -v '^#' "$OMADORA_INSTALL/omadora-base.groups" | grep -v '^$')
sudo dnf group install -y "${groups[@]}"

# Install base packages
mapfile -t packages < <(grep -v '^#' "$OMADORA_INSTALL/omadora-base.packages" | grep -v '^$')
sudo dnf install -y "${packages[@]}"

# Install copr packages
mapfile -t packages < <(grep -v '^#' "$OMADORA_INSTALL/omadora-copr.packages" | grep -v '^$')
sudo dnf install -y "${packages[@]}"
