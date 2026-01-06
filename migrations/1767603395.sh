echo "Add required packages"
sudo dnf install -y gnome-keyring xdg-terminal-exec

echo "Update theme symlinks"
for f in ~/.local/share/omadora/themes/*; do ln -nfs "$f" ~/.config/omadora/themes/; done

echo "Update application desktop files, icons, and mimetype associations"
bash "$OMADORA_PATH/install/config/mimetypes.sh"

echo "Add default webapps"
omadora-webapp-install "Google Maps" https://maps.google.com "Google Maps.png"
omadora-webapp-install "ChatGPT" https://chatgpt.com/ ChatGPT.png
omadora-webapp-install "YouTube" https://youtube.com/ YouTube.png

echo "Update uwsm config"
omadora-refresh-config uwsm/env
omadora-refresh-config uwsm/default
omadora-state set relaunch-required

echo "Update hyprland configs"
omadora-refresh-hypridle
omadora-refresh-hyprland
omadora-refresh-hyprlock
omadora-refresh-hyprsunset
omadora-refresh-config hypr/windows.conf
omadora-refresh-fastfetch
omadora-refresh-waybar
omadora-refresh-wofi

echo "Update other configs"
omadora-refresh-config alacritty/alacritty.toml
omadora-refresh-config btop/btop.conf
omadora-refresh-config fcitx5/conf/clipboard.conf
omadora-refresh-config ghostty/config
omadora-refresh-config systemd/user/omadora-battery-monitor.service
omadora-refresh-config xdg-terminals.list

echo "Add a default keyring for gnome-keyring that unlocks on login"
if [ -f "$HOME/.local/share/keyrings/Default_keyring.keyring" ] || [ -f "$HOME/.local/share/keyrings/default" ]; then
    if gum confirm "Do you want to replace existing keyring with one that's auto-unlocked on login?"; then
        bash "$OMADORA_PATH/install/login/default-keyring.sh"
    fi
else
    bash "$OMADORA_PATH/install/login/default-keyring.sh"
fi

echo "Copy hooks examples"
cp -r "$OMADORA_PATH"/config/omadora/* "$HOME"/.config/omadora/

omadora-state set reboot-required
