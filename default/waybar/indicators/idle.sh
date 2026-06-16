#!/bin/bash

if systemctl --quiet --user is-active hypridle.service; then
  echo '{"text": ""}'
else
  echo '{"text": "󱫖", "tooltip": "Idle lock disabled", "class": "active"}'
fi
