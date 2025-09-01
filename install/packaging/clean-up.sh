#!/bin/bash

# Clean up unwanted packages that may have been installed
sudo group remove -y \
  networkmanager-submodules

sudo dnf remove -y \
  kitty \
  NetworkManager* \
  nwg-panel

sudo rm -rf /etc/NetworkManager
