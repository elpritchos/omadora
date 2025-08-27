#!/bin/bash

# Copy Fedora X11 keyboard layout to Hyprland config
hyprconf="$HOME/.config/hypr/hyprland.conf"

# Get layout and variant using localectl
layout=$(localectl status | awk -F: '/X11 Layout/ {gsub(/ /,"",$2); print $2}')
variant=$(localectl status | awk -F: '/X11 Variant/ {gsub(/ /,"",$2); print $2}')

if [[ -n "$layout" ]]; then
  sed -i "/^[[:space:]]*kb_options *=/i\  kb_layout = $layout" "$hyprconf"
fi

if [[ -n "$variant" ]]; then
  sed -i "/^[[:space:]]*kb_options *=/i\  kb_variant = $variant" "$hyprconf"
fi
