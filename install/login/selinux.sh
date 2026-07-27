# Allow pam_gnome_keyring in a virtual-terminal login to reach the packaged
# user-level GNOME Keyring socket without granting access to other user sockets.
install_omadora_keyring_policy() {
  local policy_name="local_omadora_gnome_keyring"
  local install_root="${OMADORA_INSTALL:-$OMADORA_PATH/install}"
  local policy_source="$install_root/login/selinux/$policy_name.te"
  local policy_makefile="/usr/share/selinux/devel/Makefile"
  local policy_build_dir

  if [[ ! -f "$policy_source" ]]; then
    echo "Missing SELinux policy source: $policy_source" >&2
    return 1
  fi

  if [[ ! -f "$policy_makefile" ]]; then
    echo "Missing SELinux policy build support: $policy_makefile" >&2
    echo "Install selinux-policy-devel before configuring GNOME Keyring." >&2
    return 1
  fi

  policy_build_dir="$(mktemp -d)"
  install -m 0644 "$policy_source" "$policy_build_dir/$policy_name.te"

  if ! make -C "$policy_build_dir" -f "$policy_makefile" "$policy_name.pp"; then
    rm -rf -- "$policy_build_dir"
    echo "Failed to build SELinux policy: $policy_name" >&2
    return 1
  fi

  if ! sudo semodule -X 300 -i "$policy_build_dir/$policy_name.pp"; then
    rm -rf -- "$policy_build_dir"
    echo "Failed to install SELinux policy: $policy_name" >&2
    return 1
  fi

  rm -rf -- "$policy_build_dir"
}

install_omadora_keyring_policy
unset -f install_omadora_keyring_policy
