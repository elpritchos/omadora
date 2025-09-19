if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cp -R ~/.local/share/omadora/config/nvim/* ~/.config/nvim/
  rm -rf ~/.config/nvim/.git
fi
