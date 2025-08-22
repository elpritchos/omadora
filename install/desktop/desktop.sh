#!/bin/bash

sudo dnf install -y \
  xdg-user-dirs \
  brightnessctl \
  playerctl \
  pamixer \
  wireplumber \
  fcitx5 \
  fcitx5-gtk \
  fcitx5-qt \
  fcitx5-configtool \
  chromium \
  imv \
  nautilus \
  evince

xdg-user-dirs-update
