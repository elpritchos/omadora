#!/bin/bash

sudo systemctl set-default graphical.target

if ! command -v uwsm &>/dev/null || ! command -v plymouth &>/dev/null; then
  sudo dnf install -y uwsm plymouth
fi

if [ "$(plymouth-set-default-theme)" != "details" ]; then
  sudo plymouth-set-default-theme -R details
fi
