# Setup login keyring
profile_name="omadora"
profile_id="custom/$profile_name"
profile_dir="/etc/authselect/custom/$profile_name"
postlogin="$profile_dir/postlogin"
keyring_auth_line='auth        optional                   pam_gnome_keyring.so only_if=login                   {include if "with-pam-gnome-keyring"}'

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

unset profile_name
unset profile_id
unset profile_dir
unset postlogin
unset keyring_auth_line
