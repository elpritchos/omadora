# Omadora

This is my minimal functional install of Hyprland on Fedora, based on the Omarchy implementation and patterns.
It provides a more stable release cycle with tested and curated packages.

Omadora purposely does not include all the apps and features included with Omarchy.
It is intended to be a minimal install that matches the base functionality to allow users to build from.
However, as the implementation closely matches Omarchy, adding features from Omarchy should be simple.

Read more about Omarchy itself at [omarchy.org](https://omarchy.org).

## Important

Omadora attempts to install only packages from the official Fedora repositories, currently with the exception of a few Hyprland related packages, and mise.
These are provided by the [solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/) and [jdxcode/mise](https://copr.fedorainfracloud.org/coprs/jdxcode/mise/) COPRs respectively, and as such, users should perform their own due diligence to ensure these are safe to install.

## Installation

Install the Fedora Custom Operating System base install using the [Everything Network Installer](https://alt.fedoraproject.org/).
Similar to Omarchy, it is recommended to use drive encryption, disable root, and add a privileged user.

Install git (`sudo dnf install -y git`) and clone this repo to the `~/.local/share/omadora` directory.

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

## Contribution

Feel free to submit issues and PRs for improvement, I will do my best but cannot guarantee timely updates.

If you like this project, then please also feel free to...

[![Buy Me a Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://www.buymeacoffee.com/elpritchos)

## License

Omadora is released under the [MIT License](https://opensource.org/licenses/MIT).

