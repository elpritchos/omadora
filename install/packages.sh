#!/bin/bash

sudo dnf group install -y \
  development-libs \
  fonts \
  hardware-support \
  multimedia

sudo dnf install -y \
  alacritty \
  bat \
  bind-utils \
  brightnessctl \
  btop \
  cascadia-code-nf-fonts \
  cascadia-mono-nf-fonts \
  chromium \
  dbus-tools \
  evince \
  fastfetch \
  fcitx5 \
  fcitx5-configtool \
  fcitx5-gtk \
  fcitx5-qt \
  fd-find \
  fontawesome-fonts-all \
  fzf \
  gnome-themes-extra \
  google-noto-fonts-common \
  gum \
  gvfs-mtp \
  gvfs-smb \
  hypridle \
  hyprland \
  hyprland-qtutils \
  hyprlock \
  hyprpicker \
  hyprpolkitagent \
  hyprshot \
  hyprsunset \
  imv \
  iputils \
  iwd \
  kvantum-qt5 \
  mako \
  mise \
  mpv \
  nautilus \
  neovim \
  pciutils \
  pipx \
  playerctl \
  plocate \
  power-profiles-daemon \
  ripgrep \
  satty \
  slurp \
  sushi \
  swaybg \
  tar \
  tldr \
  unzip \
  usbutils \
  uwsm \
  waybar \
  wf-recorder \
  wget \
  whois \
  wl-clipboard \
  wofi \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-hyprland \
  xdg-user-dirs \
  xmlstarlet \
  yaru-icon-theme \
  zoxide
