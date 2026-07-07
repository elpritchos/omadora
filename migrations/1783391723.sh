#!/usr/bin/env bash
set -euo pipefail

echo "Install v4l-utils package for webcam screenrecord"

sudo dnf install -y v4l-utils
