#!/bin/bash

# Keep alive sudo during install
if ! sudo -n true 2>/dev/null; then
  sudo -v
fi
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
