#!/usr/bin/env bash
set -euo pipefail

echo "Refresh Omadora Aether Neovim plugin config"

user_config_file="$HOME/.config/nvim/lua/plugins/omadora-aether.lua"
default_config_file="${OMADORA_PATH:-$HOME/.local/share/omadora}/default/nvim/lua/plugins/omadora-aether.lua"
backup_config_file="$user_config_file.bak.$(date +%s)"

cp -f "$user_config_file" "$backup_config_file" 2>/dev/null
cp -f "$default_config_file" "$user_config_file" 2>/dev/null

if cmp -s "$user_config_file" "$backup_config_file"; then
  rm "$backup_config_file"
else
  echo -e "\e[31mReplaced $user_config_file with new Omadora default.\nSaved backup as ${backup_config_file}.\n\n\e[32mChanges:\e[0m"
  diff "$user_config_file" "$backup_config_file" || true
fi
