# Install base groups
mapfile -t groups < <(grep -v '^#' "$OMADORA_INSTALL/omadora-base.groups" | grep -v '^$')

# Exclude hardware-support group on Asahi Linux
# (tries to install nvidia-gpu)
if grep -q 'asahi' /etc/os-release 2>/dev/null || uname -r | grep -q 'asahi'; then
    groups=("${groups[@]/hardware-support/}")
fi

sudo dnf group install -y "${groups[@]}"

# Install base packages
mapfile -t packages < <(grep -v '^#' "$OMADORA_INSTALL/omadora-base.packages" | grep -v '^$')
sudo dnf install -y "${packages[@]}"
