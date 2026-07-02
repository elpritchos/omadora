ICON_DIR="$HOME/.local/share/applications/icons"

# HACK: Sleep added to allow for window resize
omadora-exec omadora-tui-install "Disk Usage" "bash -c 'sleep 0.1; dust -r; read -n 1 -s'" float "$ICON_DIR/Disk Usage.png"
