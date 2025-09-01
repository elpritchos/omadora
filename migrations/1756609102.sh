echo "Ensure packages installed"
source "$OMADORA_PATH/install/packages.sh"

echo "Update configs"
omadora-refresh-config alacritty/alacritty.toml
omadora-refresh-fastfetch

echo "Symlink files needed for Nautilus navigation icons"
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg
sudo gtk-update-icon-cache /usr/share/icons/Yaru
pkill -x nautilus || true
