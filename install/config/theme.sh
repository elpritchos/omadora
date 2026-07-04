# Set links for Nautilus action icons
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg

sudo gtk-update-icon-cache /usr/share/icons/Yaru

# Set base system fonts
gsettings set org.gnome.desktop.interface font-name "Adwaita Sans 11"
gsettings set org.gnome.desktop.interface document-font-name "Adwaita Sans 12"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 10.5"

# Setup user theme folder
mkdir -p ~/.config/omadora/themes

# Install Omarchy themes
omadora-exec omadora-theme-install-omarchy -y

# Set initial theme
omadora-exec omadora-theme-set "Rose Pine Darker" 2>/dev/null

# Set specific app links for current theme
ln -snf ~/.config/omadora/current/theme/neovim.lua ~/.config/nvim/lua/plugins/omadora-theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omadora/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/omadora/current/theme/mako.ini ~/.config/mako/config

# Screensaver
pipx install terminaltexteffects==0.14.2
