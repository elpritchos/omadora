#!/bin/bash

OMADORA_MIGRATIONS_STATE_PATH=~/.local/state/omadora/migrations
mkdir -p $OMADORA_MIGRATIONS_STATE_PATH

for file in ~/.local/share/omadora/migrations/*.sh; do
  touch "$OMADORA_MIGRATIONS_STATE_PATH/$(basename "$file")"
done
