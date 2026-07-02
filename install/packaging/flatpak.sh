# Add flathub to flatpak sources
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install default flatpaks
flatpak install --noninteractive flathub com.dec05eba.gpu_screen_recorder
flatpak install --noninteractive flathub org.localsend.localsend_app

# Install cli wrappers
omadora-exec omadora-flatpak-cmd-install org.localsend.localsend_app localsend
omadora-exec omadora-flatpak-cmd-install com.dec05eba.gpu_screen_recorder gpu-screen-recorder

# Add flatpak overrides
flatpak override --user --filesystem=home --filesystem=/tmp/localsend org.localsend.localsend_app
