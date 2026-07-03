# Copy all bundled icons to the applications/icons directory
ICON_DIR="$HOME/.local/share/applications/icons"
ICON_SOURCE_DIR="${OMADORA_PATH:-$HOME/.local/share/omadora}/applications/icons"

if [[ ! -d "$ICON_SOURCE_DIR" ]]; then
  echo "Missing bundled application icons directory: $ICON_SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$ICON_DIR"
cp "$ICON_SOURCE_DIR"/*.png "$ICON_DIR/"
