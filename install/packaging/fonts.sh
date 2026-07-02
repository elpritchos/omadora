# Add popular nerd fonts
fonts_dir="$HOME/.local/share/fonts"

mkdir -p "$fonts_dir"

fonts=(JetBrainsMono CascadiaCode FiraCode)

for font in "${fonts[@]}"; do
  echo "Installing font: ${font}..."
  tmpdir="$(mktemp -d)"

  zipfile="$tmpdir/${font}.zip"
  url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip"
  curl -sL -f -o "$zipfile" "$url" || wget -qO "$zipfile" "$url"

  dst="$fonts_dir/$font"
  mkdir -p "$dst"
  unzip -j -o "$zipfile" '*.ttf' '*.otf' -d "$dst" >/dev/null 2>&1

  rm -rf "$tmpdir"
done

fc-cache -f
