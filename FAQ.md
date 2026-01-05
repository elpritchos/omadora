# Frequently Asked Questions

## How do I perform a WiFi only install?

If performing a WiFi only install, you will likely need to select and install the `networkmanager-submodules` group temporarily during the Fedora installation steps.
After the Fedora OS installation, `nmcli` can be used to connect to your WiFi network.

When starting the Omadora install the guard check may prompt due to the extra package group being installed, this is fine to continue.
During the install Network Manager will be completely removed and replaced with the `iwd` package to handle WiFi connections.

After installation, use `iwctl` or the Wiremix TUI to reconnect to your WiFi network as usual.

> **NOTE:** There is also a chance you may be missing the correct WiFi device drivers after the initial Fedora installation, in this case, you can use the bootable media to boot into Recovery Mode and get a shell, then `chroot /mnt/sysimage`, and from there connect and install the Hardware Support package group  `sudo dnf group install -y hardware-support`, or determine and install the specific drivers needed.

## Where are all the apps that are provided by default in Omarchy?

This is a conscious decision not to include all the applications and configuration options provided by Omarchy to minimise bloat and only install functionality that would be expected of a minimal desktop environment, leaving software installation choices to the user.

Many of these additional apps can be installed via the default official Fedora repositories or as a flatpak via [Flathub](https://flathub.org) if needed.

## Why are the Waybar glyphs so small with the default font?

The default font is the _Cascadia Mono NF_ font which is the only Nerd Font included within the offical Fedora repositories.
The glyphs in this font are the same width as the rest of the font which makes them appear small in comparison to other [Nerd Fonts](https://www.nerdfonts.com/font-downloads).

If larger glyphs are desired, then install the [CaskaydiaMono Nerd Font](https://www.nerdfonts.com/font-downloads#:~:text=CaskaydiaMono) or similar Nerd Fonts to the `~/.local/share/fonts` directory and rebuild the cache with `fc-cache -f`.
The fonts should now be available for selection via the Omadora style menu.

## Why have the Omarchy themes been modified?

Neovim theme config files have been modified to load without the LazyVim plugin so that any Neovim configuration that uses the Lazy plugin manager can use the themes simply by symlinking in the theme plugin from `~/.config/omadora/current/theme/neovim.lua`.
However, third-party themes may still load the LazyVim plugin and would need to be modified manually after the theme install to work in the same manner.

## Where is the Omadora default plymouth theme from?

The default theme installed is from the great plymouth theme collection at [adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes).
