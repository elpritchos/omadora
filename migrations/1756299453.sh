echo "Ensure packages installed"
source $OMADORA_PATH/install/packages.sh

echo "Add fontconfig"
if [[ ! -d $HOME/.config/fontconfig ]]; then
  cp -r $OMADORA_PATH/config/fontconfig $HOME/.config/
fi

echo "Add starship config"
if [[ ! -f $HOME/.config/starship.toml ]]; then
  cp $OMADORA_PATH/config/starship.toml $HOME/.config/
fi

echo "Add brave-flags.conf"
if [[ ! -f $HOME/.config/brave-flags.conf ]]; then
  cp $OMADORA_PATH/config/brave-flags.conf $HOME/.config/
fi

echo "Copy screensaver logo"
mkdir -p $HOME/.config/omadora/branding
cp $OMADORA_PATH/logo.txt $HOME/.config/omadora/branding/screensaver.txt

echo "Update fastfetch"
mkdir -p $HOME/.config/omadora/branding
cp $OMADORA_PATH/icon.txt $HOME/.config/omadora/branding/about.txt
omadora-refresh-config fastfetch/config.jsonc

echo "Update configs"
omadora-refresh-config hypr/bindings.conf
omadora-refresh-hyprland
omadora-refresh-hyprlock
omadora-refresh-hypridle
omadora-refresh-walker
omadora-refresh-wofi
omadora-refresh-waybar
omadora-refresh-applications

echo "Remove old desktop files and icons"
rm -f $HOME/.local/share/applications/About.desktop
rm -f $HOME/.local/share/applications/Activity.desktop
rm -f $HOME/.local/share/applications/wiremix.desktop
rm -f $HOME/.local/share/icons/hicolor/48x48/apps/Activity.png
rm -f $HOME/.local/share/icons/hicolor/48x48/apps/Arch.png
rm -f $HOME/.local/share/icons/hicolor/48x48/apps/Docker.png
rm -f $HOME/.local/share/icons/hicolor/48x48/apps/Fedora.png
rm -f $HOME/.local/share/icons/hicolor/48x48/apps/Flatpak.png
