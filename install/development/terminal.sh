#!/bin/bash

#  Unneeded?: xmlstarlet
sudo dnf install -y \
  wget \
  curl \
  unzip \
  tar \
  iputils \
  fd-find \
  fzf \
  ripgrep \
  zoxide \
  bat \
  jq \
  wl-clipboard \
  fastfetch \
  btop \
  man \
  tldr \
  less \
  whois \
  plocate \
  bash-completion \
  alacritty \
  cargo \
  pipewire-devel \
  clang \
  neovim

cargo install \
  impala \
  wiremix \
  eza
