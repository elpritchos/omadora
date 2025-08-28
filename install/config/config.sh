#!/bin/bash

xdg-user-dirs-update

# Copy over configs
mkdir -p ~/.config
cp -R ~/.local/share/omadora/config/* ~/.config/

# Use default bashrc
cp ~/.local/share/omadora/default/bashrc ~/.bashrc
