-- Omadora Hyprland setup: helpers, defaults, and current theme overrides.

require("default.hypr.helpers")

-- Use Omadora defaults, but don't edit these directly.
require("default.hypr.autostart")
require("default.hypr.bindings.media")
require("default.hypr.bindings.tiling")
require("default.hypr.bindings.utilities")
require("default.hypr.looknfeel")
require("default.hypr.input")
require("default.hypr.windows")

-- Current theme overrides.
do
  local paths = require("default.hypr.paths")
  local theme = io.open(paths.config_home .. "/omadora/current/theme/hyprland.lua", "r")
  if theme then
    theme:close()
    require("omadora.current.theme.hyprland")
  end
end
