#!/bin/bash

sudo systemctl set-default graphical.target

if [ "$(plymouth-set-default-theme)" != "details" ]; then
  echo "Setting plymouth theme..."
  sudo plymouth-set-default-theme -R details
fi
