# Setup login keyring
configure_omadora_login_keyring() {
  local keyrings_dir="$HOME/.local/share/keyrings"
  local default_keyring="login"

  mkdir -p "$keyrings_dir"
  chmod 700 "$keyrings_dir"
  printf '%s\n' "$default_keyring" >"$keyrings_dir/default"

  local profile_name="omadora"
  local profile_id="custom/$profile_name"
  local profile_dir="/etc/authselect/custom/$profile_name"
  local postlogin="$profile_dir/postlogin"
  local keyring_auth_line='auth        optional                   pam_gnome_keyring.so only_if=login                   {include if "with-pam-gnome-keyring"}'

  if ! sudo test -d "$profile_dir"; then
    sudo authselect create-profile "$profile_name" -b local --symlink-meta
  fi

  if ! sudo grep -Eq '^[[:space:]]*auth[[:space:]]+optional[[:space:]]+pam_gnome_keyring\.so([[:space:]].*)?$' "$postlogin"; then
    printf '\n%s\n' "$keyring_auth_line" | sudo tee -a "$postlogin" >/dev/null
  fi

  sudo authselect select "$profile_id" \
    with-silent-lastlog \
    with-mdns4 \
    with-pam-gnome-keyring

  sudo authselect apply-changes
}

configure_omadora_login_keyring
unset -f configure_omadora_login_keyring
