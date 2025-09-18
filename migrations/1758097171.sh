echo "Update application desktop files and icons"
omadora-refresh-applications

echo "Update Disk Usage TUI icon"
ICON_DIR="$HOME/.local/share/applications/icons"
omadora-tui-remove "Disk Usage" &>/dev/null
bash -c "$OMADORA_PATH/install/packaging/icons.sh"
omadora-tui-install "Disk Usage" "bash -c 'dust -r; read -n 1 -s'" float "$ICON_DIR/Disk Usage.png"
