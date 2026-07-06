# Omadora

This is a minimal install of Hyprland for Fedora 44, based on the Omarchy implementation and patterns.
It provides a more stable release cycle with tested and curated packages.

Omadora purposely does not include all the apps and features included with Omarchy, as it's intended to be a minimal install that provides core desktop functionality to allow users to build from.
However, as the implementation closely matches Omarchy, adding the extra features from Omarchy should be simple if you wish to do so.

Read more about Omarchy itself at [omarchy.org](https://omarchy.org).

> **Note**
> Omadora attempts to install only packages from the official Fedora repositories, currently with the exception of Hyprland, mise, and starship related packages provided from COPR.
> Users should perform their own due diligence with regard to accepting the risk of installing packages from this third-party repository.

## Installation

Install the Fedora 44 Custom Operating System base install using the [Everything Network Installer](https://download.fedoraproject.org/pub/fedora/linux/releases/44/Everything).
Similar to Omarchy, it is recommended to use drive encryption, disable root, and add a privileged user.

To install, run the following:

```
curl -fsSL https://raw.githubusercontent.com/elpritchos/omadora/master/boot.sh | bash
```

Or install manually:

Install git (`sudo dnf install -y git`) and clone this repo to the `~/.local/share/omadora` directory.

```
git clone https://github.com/elpritchos/omadora ~/.local/share/omadora
```

Run `~/.local/share/omadora/install.sh` to install.

> **Tip**
> For a WiFi only install, see the [FAQ](FAQ.md) for help.

## Usage

Omadora does not use the seamless login implemented in Omarchy, therefore once logged in, start Omadora using `omadora`.

Stop Omadora by using the power menu or executing `omactl session logout`.

## Frequently Asked Questions

Check out the [FAQ.md](FAQ.md).

## Contribution

Please feel free to submit issues and PRs for improvement, I'll do my best to address them.

If you like this project then please help me out by [Sponsoring via Github](https://github.com/sponsors/elpritchos) or ...

[![Buy Me a Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://www.buymeacoffee.com/elpritchos)

## License

Omadora is released under the [MIT License](https://opensource.org/licenses/MIT).
