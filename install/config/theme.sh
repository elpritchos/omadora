#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"

# Setup theme links
mkdir -p ~/.config/omadora/themes
for f in ~/.local/share/omadora/themes/*; do ln -nfs "$f" ~/.config/omadora/themes/; done

# Set initial theme
mkdir -p ~/.config/omadora/current
ln -snf ~/.config/omadora/themes/rose-pine-darker ~/.config/omadora/current/theme
ln -snf ~/.config/omadora/current/theme/backgrounds/01_background.png ~/.config/omadora/current/background

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omadora/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/omadora/current/theme/mako.ini ~/.config/mako/config

# Screensaver
pipx install terminaltexteffects
