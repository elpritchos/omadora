xdg-user-dirs-update

mkdir -p "$HOME/.config/gtk-3.0"
touch "$HOME/.config/gtk-3.0/bookmarks"
for dir in Desktop Documents Downloads Music Pictures Public Templates Videos; do
  printf 'file://%s/%s %s\n' "$HOME" "$dir" "$dir" >>~/.config/gtk-3.0/bookmarks
done
