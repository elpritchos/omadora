#!/bin/bash

sudo dnf copr enable -y solopasha/hyprland

# Missing: walker
sudo dnf install -y \
  hyprland \
  hyprshot \
  hyprpicker \
  hyprlock \
  hypridle \
  hyprsunset \
  hyprpolkitagent \
  hyprland-qtutils \
  waybar \
  mako \
  swaybg \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  wofi

