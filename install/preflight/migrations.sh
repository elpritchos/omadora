OMADORA_MIGRATIONS_STATE_PATH="$HOME"/.local/state/omadora/migrations
mkdir -p "$OMADORA_MIGRATIONS_STATE_PATH"

files=("$HOME"/.local/share/omadora/migrations/*.sh)

for file in "${files[@]}"; do
  [[ -e "$file" ]] || continue
  touch "$OMADORA_MIGRATIONS_STATE_PATH/${file##*/}"
done
