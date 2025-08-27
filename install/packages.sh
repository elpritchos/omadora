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
  evince \
  fastfetch \
  fcitx5 \
  fcitx5-configtool \
  fcitx5-gtk \
  fcitx5-qt \
  fd-find \
  fontawesome-fonts-all \
  fzf \
  gnome-keyring \
  gnome-themes-extra \
  google-noto-fonts-common \
  gum \
  hypridle \
  hyprland \
  hyprland-protocols \
  hyprland-qtutils \
  hyprlock \
  hyprpicker \
  hyprpolkitagent \
  hyprshot \
  hyprsunset \
  imv \
  iputils \
  iwd \
  jetbrains-mono-fonts-all \
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
  xml-starlet \
  yaru-icon-theme \
  zoxide

# Clean up any unwanted packages that may have been installed
sudo dnf remove -y \
  kitty \
  NetworkManager* \
  nwg-panel
