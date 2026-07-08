echo "Install ported Adwaita gtk3 themes..."

sudo dnf install -y adw-gtk3-theme

sudo flatpak install --system --noninteractive -y flathub org.gtk.Gtk3theme.adw-gtk3
sudo flatpak install --system --noninteractive -y flathub org.gtk.Gtk3theme.adw-gtk3-dark

systemctl --user restart omadora-polkitagent.service
