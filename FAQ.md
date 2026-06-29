# Frequently Asked Questions

## How do I perform a WiFi only install?

If performing a WiFi only install, you will likely need to select and install the `networkmanager-submodules` group temporarily during the Fedora installation steps.
After the Fedora OS installation, `nmcli` can be used to connect to your WiFi network.

When starting the Omadora install the guard check may prompt due to the extra package group being installed, this is fine to continue.
During the install Network Manager will be completely removed and replaced with the `iwd` package to handle WiFi connections.

After installation, use `iwctl` or the Wiremix TUI to reconnect to your WiFi network as usual.

> **NOTE:** There is also a chance you may be missing the correct WiFi device drivers after the initial Fedora installation, in this case, you can use the bootable media to boot into Recovery Mode and get a shell, then `chroot /mnt/sysimage`, and from there connect and install the Hardware Support package group  `sudo dnf group install -y hardware-support`, or determine and install the specific drivers needed.

## Where is the documentation for Omadora?

In general, Omadora reimplements much of the same functionality, keybindings, etc., that is in Omarchy, and therefore the [The Omarchy Manual](https://learn.omacom.io/) can be used as a guide for Omadora.

The [Hyprland Wiki](https://wiki.hypr.land) is also great reference documentation for the configuration of Hyprland.

However, the best resource for understanding Omadora is to read and understand the scripts within this repository with which you are executing.

## How do I keep Omadora updated?

There is an update indicator which appears in the top right of the Waybar that indicates update status; clicking this will pop a terminal and execute `omadora-update`.
The `omadora-update` script can also be run manually, and in both cases will update Omadora to the latest version, along with system packages, firmware, flatpaks, and cargo-installed binaries.

## Where are all the apps that are provided by default in Omarchy?

This is a conscious decision not to include all the applications and configuration options provided by Omarchy to minimise bloat and only install functionality that would be expected of a minimal desktop environment, leaving software installation choices to the user.

Many of these additional apps can be installed via the default official Fedora repositories or as a flatpak via [Flathub](https://flathub.org) if needed.

## Do I have to use the LazyVim starter?

No. You can still use the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager configured to disable the 'LazyVim/LazyVim' plugin, and ensure the theme plugin from `~/.config/omadora/current/theme/neovim.lua` is symlinked to the your lazy plugins directory.

## Where is the Omadora default plymouth theme from?

The default theme installed is from the great plymouth theme collection at [adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes).
