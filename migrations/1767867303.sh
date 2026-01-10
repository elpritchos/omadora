echo "Install required packages"
sudo dnf install -y libxkbcommon-utils

echo "Copy in extensions examples"
cp -r "$OMADORA_PATH/config/omadora/extensions" "$HOME/.config/omadora/extensions"

echo "Copy configs for kitty if not existing"
if [[ ! -f ~/.config/kitty/kitty.conf ]]; then
  mkdir -p ~/.config/kitty
  cp -Rpf "$OMADORA_PATH/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
fi

echo "Update configs"
omadora-refresh-hypridle
omadora-refresh-waybar
