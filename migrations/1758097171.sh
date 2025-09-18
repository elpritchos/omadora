echo "Update application desktop files and icons"
omadora-refresh-applications

echo "Update disk usage TUI icon"
ICON_DIR="$HOME/.local/share/applications/icons"
omadora-tui-remove "Disk Usage" &>/dev/null
bash -c "$OMADORA_PATH/install/packaging/icons.sh"
omadora-tui-install "Disk Usage" "bash -c 'dust -r; read -n 1 -s'" float "$ICON_DIR/Disk Usage.png"

echo "Update uwsm config"
omadora-refresh-config uwsm/env
omadora-refresh-config uwsm/default
touch "$HOME/.local/state/omadora/relaunch-required"

echo "Update hypr config"
omadora-refresh-config hypr/input.conf
omadora-refresh-config hypr/bindings.conf

echo "Update ghostty config"
omadora-refresh-config ghostty/config

echo "Add gnome calculator"
sudo dnf install -y gnome-calculator
