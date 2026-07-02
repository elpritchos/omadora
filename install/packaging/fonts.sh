# Add popular nerd fonts
fonts_dir="$HOME/.local/share/fonts"

mkdir -p "$fonts_dir"

fonts=(JetBrainsMono CascadiaCode FiraCode)

for font in "${fonts[@]}"; do
  echo "Installing Nerd Font: ${font}..."
  tmpdir="$(mktemp -d)"

  zipfile="$tmpdir/${font}.zip"
  url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.zip"
  stage="$tmpdir/$font"
  backup="$tmpdir/${font}.previous"

  dst="$fonts_dir/$font"
  if curl --fail --location --silent --show-error \
    --retry 3 --retry-delay 2 --connect-timeout 10 --max-time 120 \
    --output "$zipfile" "$url" &&
    unzip -tq "$zipfile" >/dev/null &&
    mkdir -p "$stage" &&
    { unzip -j -o "$zipfile" '*.ttf' -d "$stage" >/dev/null 2>&1 || true; } &&
    { unzip -j -o "$zipfile" '*.otf' -d "$stage" >/dev/null 2>&1 || true; } &&
    find "$stage" -type f \( -name '*.ttf' -o -name '*.otf' \) -print -quit | grep -q .; then
    if { [[ ! -e $dst ]] || mv "$dst" "$backup"; } && mv "$stage" "$dst"; then
      rm -rf "$backup"
    else
      echo "Warning: failed to install ${font} Nerd Font; continuing."
      { [[ ! -e $backup ]] || { rm -rf "$dst" && mv "$backup" "$dst"; }; } || true
    fi
  else
    echo "Warning: failed to install ${font} Nerd Font; continuing."
  fi

  rm -rf "$tmpdir"
done

if ! fc-cache -f; then
  echo "Warning: failed to refresh font cache; continuing."
fi

unset fonts_dir fonts font tmpdir zipfile url stage backup dst
