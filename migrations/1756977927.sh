echo "Update Ghostty config"

if [ -d "$HOME/.config/ghostty" ]; then
    omadora-refresh-config ghostty/config || true
else
    cp -r "$OMADORA_PATH/config/ghostty" "$HOME/.config/"
fi
