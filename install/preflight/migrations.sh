#!/bin/bash

omadora_migrations_state_path=~/.local/state/omadora/migrations
mkdir -p $omadora_migrations_state_path

for file in ~/.local/share/omadora/migrations/*.sh; do
  touch "$omadora_migrations_state_path/$(basename "$file")"
done
