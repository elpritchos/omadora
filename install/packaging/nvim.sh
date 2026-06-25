# Add LazyVim as base Neovim config
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter "$HOME"/.config/nvim

  rm -rf "$HOME"/.config/nvim/.git

  cp -r "$HOME"/.local/share/omadora/default/nvim/* "$HOME"/.config/nvim
fi
