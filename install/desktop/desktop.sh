#!/bin/bash

sudo dnf group install -y \
  multimedia \
  hardware-support

sudo dnf install -y \
  xdg-user-dirs \
  brightnessctl \
  playerctl \
  pamixer \
  fcitx5 \
  fcitx5-gtk \
  fcitx5-qt \
  fcitx5-configtool \
  chromium \
  imv \
  mpv \
  nautilus \
  sushi \
  evince

xdg-user-dirs-update
