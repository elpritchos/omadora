#!/bin/bash

# Copy over Omadora configs
cp -R ~/.local/share/omadora/config/* ~/.config/

# Use default bashrc from Omadora
cp ~/.local/share/omadora/default/bashrc ~/.bashrc

# Ensure application directory exists for update-desktop-database
mkdir -p ~/.local/share/applications

