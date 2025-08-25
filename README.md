# Omadora

This is my minimal functional install of Hyprland on Fedora, based on the Omarchy implementation and patterns.
It provides a more stable release cycle with tested and curated packages.

Omadora purposely does not include all the apps and features included with Omarchy.
It is intended to be a minimal install that matches the base functionality to allow users to build from.
However, as the implementation closely matches Omarchy, adding features from Omarchy should be simple.

Read more at about Omarchy itself at [omarchy.org](https://omarchy.org).

## Important

Omadora attempts to install only packages from the official Fedora repositories, currently with the exception of a few Hyprland related packages.
These are provided by the [solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/) COPR, and as such, users should perform their own due diligence to ensure Omadora is safe to install.

Some functionality may be broken.
Feel free to submit issues or PRs for improvement, however there are no guarantees for timely fixes or updates.

## Installation

Install the Fedora Custom Operating System base install using the [Everything Network Installer](https://alt.fedoraproject.org/).
Similar to Omarchy, it is recommended to use drive encryption, disable root, and add a privileged user.

Install git (`sudo dnf install -y git`) and clone this repo to the `~/.local/share/omadora` directory.

Run `~/.local/share/omadora/install.sh` to install.

### WiFi only install help

If performing a WiFi only install, you will likely need to select and install the `networkmanager-submodules` group temporarily during the Fedora installation steps.

After the OS install, `nmcli` can be used to connect to your WiFi network and install the `iwd` package, `sudo dnf install -y iwd`.
The Network Manager Submodules group can then be removed `sudo dnf group remove networkmanager-submodules`, along with all other Network Manager packages `sudo dnf remove NetworkManager*`.
From there you should be able to connect to your WiFi network using `iwctl`, and continue with the general installation instructions above.

> **NOTE:** You may need to manually enable the built-in DHCP client for IWD as per the [Arch Wiki](https://wiki.archlinux.org/title/Iwd).

> **NOTE:** There is also a chance you may be missing the correct WiFi device drivers after the Fedora install, in this case, you can use the bootable media to boot into Recovery Mode and get a shell, then `chroot /mnt/sysimage`, and from there connect and install the Hardware Support package group  `sudo dnf group install -y hardware-support`, or determine and install the specific drivers needed.
> You may also need to disable the guard checks in the Omadora `install.sh` due to the additional package group being installed.

## Usage

Omadora does not use the seamless login implemented in Omarchy, therefore once logged in, start Omadora using `omadora`.
Stop Omadora by using the power menu or executing the bash command `uswm stop`.

## License

Omadora is released under the [MIT License](https://opensource.org/licenses/MIT).

