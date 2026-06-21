# Add flathub to flatpak sources
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install default flatpaks
flatpak install --noninteractive flathub com.dec05eba.gpu_screen_recorder
flatpak install --noninteractive flathub org.localsend.localsend_app
