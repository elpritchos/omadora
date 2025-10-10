abort() {
  echo -e "\e[31mOmadora install requires: $1\e[0m"
  echo

  read -p "Proceed anyway on your own accord and without assistance? [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY]) ;;
    *) exit 1 ;;
  esac
}

# Must be a Fedora distro
[[ -f /etc/fedora-release ]] || abort "Fedora"

# Must not be running as root
[ "$EUID" -eq 0 ] && abort "Running as user (not root)"

# x86_64 or ARM64 (mac)
[ "$(uname -m)" == "x86_64" || "$(uname -m)" == "aarch64" ] || abort "x86_64 CPU"

# Should be a core only install
groups=$(dnf group list --installed --hidden -q | awk 'NR>1 {print $1}')
[ "$groups" != "core" ] && abort "Core only Fedora install"

# Cleared all guards
echo "Guards: OK"
