-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Load user modules from ~/.config and Omadora defaults from $OMADORA_PATH.
package.path = os.getenv("HOME")
  .. "/.config/?.lua;"
  .. (os.getenv("OMADORA_PATH") or (os.getenv("HOME") .. "/.local/share/omadora"))
  .. "/?.lua;"
  .. package.path

-- All Omadora default setups
require("default.hypr.omadora")

---- Change your own setup in these files and override defaults.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

---- Toggle config flags dynamically
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
