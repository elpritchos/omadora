# Add flathub to flatpak sources
sudo flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install default flatpaks
sudo flatpak install --system --noninteractive -y flathub com.dec05eba.gpu_screen_recorder
sudo flatpak install --system --noninteractive -y flathub org.localsend.localsend_app

# Add flatpak overrides
flatpak override --user --filesystem=home --filesystem=/tmp/localsend org.localsend.localsend_app

# Install cli wrappers
omadora-exec omadora-flatpak-cmd-install org.localsend.localsend_app localsend
omadora-exec omadora-flatpak-cmd-install com.dec05eba.gpu_screen_recorder gpu-screen-recorder
