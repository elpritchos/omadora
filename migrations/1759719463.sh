echo "Add the Flexoki Light theme"

if [[ ! -L ~/.config/omadora/themes/flexoki-light ]]; then
  ln -nfs ~/.local/share/omadora/themes/flexoki-light ~/.config/omadora/themes/
fi
