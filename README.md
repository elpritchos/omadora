# Omadora

This is a minimal functional install of Hyprland for Fedora 42, based on the Omarchy implementation and patterns.
It provides a more stable release cycle with tested and curated packages.

Omadora purposely does not include all the apps and features included with Omarchy, as it's intended to be a minimal install that provides core desktop functionality to allow users to build from.
However, as the implementation closely matches Omarchy, adding extra features from Omarchy should be simple if you wish to do so.

Read more about Omarchy itself at [omarchy.org](https://omarchy.org).

## Important

Omadora attempts to install only packages from the official Fedora repositories, currently with the exception of a few Hyprland related packages, and mise.
These are provided by the [solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/) and [jdxcode/mise](https://copr.fedorainfracloud.org/coprs/jdxcode/mise/) COPRs respectively, and as such, users should perform their own due diligence to ensure these are safe to install.

## Installation

Install the Fedora 42 Custom Operating System base install using the [Everything Network Installer](https://download.fedoraproject.org/pub/fedora/linux/releases/42/Everything).
Similar to Omarchy, it is recommended to use drive encryption, disable root, and add a privileged user.

Install git (`sudo dnf install -y git`) and clone this repo to the `~/.local/share/omadora` directory.

Run `~/.local/share/omadora/install.sh` to install.

For a WiFi only install, see the (FAQ)[FAQ.md] for help.

## Usage

Omadora does not use the seamless login implemented in Omarchy, therefore once logged in, start Omadora using `omadora`.

Stop Omadora by using the power menu or executing `omadora-cmd-stop` or `uwsm stop`.

## Frequently Asked Questions

Check out the (FAQ.md)[FAQ.md].

## Contribution

Feel free to submit issues and PRs for improvement, I will do my best to address them.

If you like this project, then please also feel free to help me out and...

[![Buy Me a Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://www.buymeacoffee.com/elpritchos)

## License

Omadora is released under the [MIT License](https://opensource.org/licenses/MIT).
