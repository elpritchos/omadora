echo "Copy configs for kitty if not existing"

if [[ ! -f ~/.config/kitty/kitty.conf ]]; then
  mkdir -p ~/.config/kitty
  cp -Rpf "$OMADORA_PATH/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
fi
