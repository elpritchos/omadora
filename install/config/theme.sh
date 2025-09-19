# Set gnome theme settings
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"

# Set links for Nautilius action icons
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg
sudo gtk-update-icon-cache /usr/share/icons/Yaru

# Setup theme links
mkdir -p ~/.config/omadora/themes
for f in ~/.local/share/omadora/themes/*; do ln -nfs "$f" ~/.config/omadora/themes/; done

# Set initial theme
mkdir -p ~/.config/omadora/current
ln -snf ~/.config/omadora/themes/rose-pine-darker ~/.config/omadora/current/theme
ln -snf ~/.config/omadora/current/theme/backgrounds/01_background.png ~/.config/omadora/current/background

# Set specific app links for current theme
ln -snf ~/.config/omadora/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omadora/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/omadora/current/theme/mako.ini ~/.config/mako/config

# Screensaver
pipx install terminaltexteffects
