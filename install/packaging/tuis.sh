ICON_DIR="$HOME/.local/share/applications/icons"

# Must run after icons are installed
omadora-tui-install "Disk Usage" "bash -c 'dust -r; read -n 1 -s'" float "$ICON_DIR/Disk Usage.png"
