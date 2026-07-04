# Build cargo bins
# INFO: Dnf packages added for cargo builds:
#   cargo clang gtk4-devel libadwaita-devel libepoxy-devel
cargo_bin_dir="$HOME/.cargo/bin"
case ":$PATH:" in
*":$cargo_bin_dir:"*) ;;
*) export PATH="$cargo_bin_dir:$PATH" ;;
esac

install_cargo_bin() {
  local package="$1"
  local bin="${2:-$package}"

  if command -v "$bin" >/dev/null 2>&1; then
    echo "Skipping $package; $bin already exists"
    return
  fi

  cargo install "$package"
}

install_cargo_bin cargo-update cargo-install-update
install_cargo_bin bluetui
install_cargo_bin impala
install_cargo_bin satty
