# Omadora

This is my minimal functional install of Hyprland on Fedora 42, based on the Omarchy implementation and patterns.
It provides a more stable release cycle with tested and curated packages.

Omadora purposely does not include all the apps and features included with Omarchy.
It is intended to be a minimal install that provides core desktop functionality to allow users to build from.
However, as the implementation closely matches Omarchy, adding extra features is simple if you wish to do so.

Read more about Omarchy itself at [omarchy.org](https://omarchy.org).

## Important

Omadora attempts to install only packages from the official Fedora repositories, currently with the exception of a few Hyprland related packages, and mise.
These are provided by the [solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/) and [jdxcode/mise](https://copr.fedorainfracloud.org/coprs/jdxcode/mise/) COPRs respectively, and as such, users should perform their own due diligence to ensure these are safe to install.

## Installation

Install the Fedora 42 Custom Operating System base install using the [Everything Network Installer](https://alt.fedoraproject.org/).
Similar to Omarchy, it is recommended to use drive encryption, disable root, and add a privileged user.

Install git (`sudo dnf install -y git`) and clone this repo to the `~/.local/share/omadora` directory.

```
git clone https://github.com/elpritchos/omadora ~/.local/share/omadora
```

Run `~/.local/share/omadora/install.sh` to install.

### WiFi only install help

If performing a WiFi only install, you will likely need to select and install the `networkmanager-submodules` group temporarily during the Fedora installation steps.
After the Fedora OS installation, `nmcli` can be used to connect to your WiFi network.

When starting the Omadora install the guard check may prompt due to the extra package group being installed, this is fine to continue.
During the install Network Manager will be completely removed and replaced with the `iwd` package to handle WiFi connections.

After installation, use `iwctl` or the Wiremix TUI to reconnect to your WiFi network as usual.

> **NOTE:** There is also a chance you may be missing the correct WiFi device drivers after the initial Fedora installation, in this case, you can use the bootable media to boot into Recovery Mode and get a shell, then `chroot /mnt/sysimage`, and from there connect and install the Hardware Support package group  `sudo dnf group install -y hardware-support`, or determine and install the specific drivers needed.

## Usage

Omadora does not use the seamless login implemented in Omarchy, therefore once logged in, start Omadora using `omadora`.
Stop Omadora by using the power menu or executing the bash command `uwsm stop`.

## Themes

Neovim theme config files have been modified to not include the LazyVim plugin and therefore any Neovim configuration that uses the Lazy plugin manager can symlink in the theme plugin from `~/.config/omadora/current/theme/neovim.lua`.
Third-party themes may still load the LazyVim plugin and would need to be modified manually after the theme install.

[Ghostty](https://ghostty.org/) config and themes have been included but requires Ghostty 1.2+ for automatic config reload and themes to work properly.
To use an older version, some of the Ghostty config files within the `themes` directory will need to be modified back to the old Ghostty theme names, and the config needs to be reloaded manually using `Ctrl-Shift-,` after each theme change.

A plymouth theme from the great collection at [adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes) has been included as the default.

## Contribution

Feel free to submit issues and PRs for improvement, I will do my best to address them.

If you like this project, then please also feel free to help me out and...

[![Buy Me a Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://www.buymeacoffee.com/elpritchos)

## License

Omadora is released under the [MIT License](https://opensource.org/licenses/MIT).
