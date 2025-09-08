#!/bin/bash

if [ "$(plymouth-set-default-theme)" != "details" ]; then
  echo "Setting plymouth theme..."
  sudo plymouth-set-default-theme -R details
fi
