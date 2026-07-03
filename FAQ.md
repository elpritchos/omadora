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

However, the best resource for understanding Omadora is to read and understand the scripts within this repository.

## How do I run the Omadora scripts?

In comparison to Omarchy, Omadora doesn't expose all scripts to the user to avoid cluttering bash completion.
Instead, any of the scripts can be executed by using the exposed `omadora-exec` tool, e.g. `omadora-exec omadora-update`, which also has bash completion to help.

There is also an exposed `omactl` frontend CLI tool which is intended to be used to interact with most Omadora functionality, however it's still a WIP which I'll continue to improve upon.
This also has help and bash completion to make things a bit nicer.

## How do I keep Omadora updated?

There is an update indicator which appears in the top right of the Waybar that indicates update status; clicking this will pop a terminal and execute the update script.
The script can be manually run via `omactl update`, and will update Omadora to the latest version, along with system packages, firmware, flatpaks, and cargo-installed binaries.
The update check will be performed a few times per day, however you can force an update check with `omactl update check`.

## Where are all the apps that are provided by default in Omarchy?

This is a conscious decision not to include all the applications and configuration options provided by Omarchy and only install functionality that would be expected of a minimal desktop environment, leaving software installation choices to the user.

## Do I have to use the LazyVim Neovim starter?

No, not at all.
You can still use the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager configured to disable the 'LazyVim/LazyVim' plugin, and ensure the theme plugin from `~/.config/omadora/current/theme/neovim.lua` is symlinked to the your lazy plugins directory.
Other than that, just use the same plugins from the `default/nvim` directory in your Neovim configuration.

Theme hot reload is provided by a forked version of the [Aether.nvim](https://github.com/bjarneo/aether.nvim) plugin, and my forked version can be seen [here](https://github.com/elpritchos/aether.nvim).

## How do I turn off the weather updates?

You can use the default keybinding <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd>, or run `omactl toggle weather` to disable/enable the weather feature.

## Where is the Omadora default plymouth theme from?

The default plymouth theme installed is from the great theme collection at [adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes).
I've modified the theme to ensure it displays correctly on multi-monitor setups.
