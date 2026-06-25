#!/bin/bash

if pgrep -f "^gpu-screen-recorder" >/dev/null 2>&1; then
  echo '{"text": "󰻂", "tooltip": "Stop recording", "class": "active"}'
else
  echo '{"text": ""}'
fi
