service_reload_waybar() {
  killall -SIGUSR2 waybar
}

service_reload_mako() {
  makoctl reload
}

service_reload_hyprland() {
  hyprctl reload
}

service_reload_btop() {
  pkill -SIGUSR2 btop
}

service_reload_alacritty() {
  if [[ -f "$HOME/.config/alacritty/alacritty.toml" ]]; then
    touch "$HOME/.config/alacritty/alacritty.toml"
  fi
}

service_reload_ghostty() {
  killall -SIGUSR2 ghostty
}

service_reload_kitty() {
  killall -SIGUSR1 kitty
}
