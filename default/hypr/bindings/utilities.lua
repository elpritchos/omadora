-- Menus.
o.bind("SUPER + SPACE", "Launch apps", o.libexec("omadora-menu apps"))
-- Not in utilities.conf; keep visible for review.
-- o.bind("SUPER + CTRL + E", "Emoji picker", { omarchy = "walker -m symbols" })
o.bind("SUPER + CTRL + C", "Capture menu", o.libexec("omadora-menu capture"))
o.bind("SUPER + CTRL + O", "Toggle menu", o.libexec("omadora-menu toggle"))
o.bind("SUPER + CTRL + H", "Hardware menu", o.libexec("omadora-menu hardware"))
o.bind("SUPER + ALT + SPACE", "Omadora menu", o.libexec("omadora-menu"))
o.bind("SUPER + SHIFT + code:201", "Omadora menu", o.libexec("omadora-menu"))
o.bind("SUPER + ESCAPE", "System menu", o.libexec("omadora-menu system"))
o.bind("XF86PowerOff", "Power menu", o.libexec("omadora-menu system"), { locked = true })
o.bind("SUPER + K", "Show key bindings", o.libexec("omadora-menu-keybindings"))
-- Not in utilities.conf; keep visible for review.
-- o.bind("SUPER + ALT + K", "Show Tmux key bindings", "omarchy-menu-tmux-keybindings")
o.bind("XF86Calculator", "Calculator", "gnome-calculator")

-- Aesthetics.
o.bind("SUPER + SHIFT + SPACE", "Toggle top bar", o.libexec("omadora-toggle-waybar"))
-- Not in utilities.conf; keep visible for review.
-- o.bind("SUPER + SHIFT + CTRL + UP", "Move Waybar to top", "omarchy-style-waybar-position top")
-- o.bind("SUPER + SHIFT + CTRL + DOWN", "Move Waybar to bottom", "omarchy-style-waybar-position bottom")
-- o.bind("SUPER + SHIFT + CTRL + LEFT", "Move Waybar to left", "omarchy-style-waybar-position left")
-- o.bind("SUPER + SHIFT + CTRL + RIGHT", "Move Waybar to right", "omarchy-style-waybar-position right")
-- Omarchy used this binding for a background switcher menu; utilities.conf cycles to the next background.
o.bind("SUPER + CTRL + SPACE", "Next theme background", o.libexec("omadora-theme-bg-next"))
o.bind("SUPER + SHIFT + CTRL + SPACE", "Theme menu", o.libexec("omadora-menu theme"))
o.bind(
  "SUPER + BACKSPACE",
  "Toggle window transparency",
  o.libexec("omadora-hyprland-window-transparency-toggle")
)
o.bind(
  "SUPER + SHIFT + BACKSPACE",
  "Toggle window gaps",
  o.libexec("omadora-hyprland-window-gaps-toggle")
)
o.bind(
  "SUPER + CTRL + BACKSPACE",
  "Toggle single-window square aspect",
  o.libexec("omadora-hyprland-window-single-square-aspect-toggle")
)

-- Notifications.
o.bind("SUPER + COMMA", "Dismiss last notification", "makoctl dismiss")
o.bind("SUPER + SHIFT + COMMA", "Dismiss all notifications", "makoctl dismiss --all")
o.bind(
  "SUPER + CTRL + COMMA",
  "Toggle silencing notifications",
  o.libexec("omadora-toggle-notification-silencing")
)
o.bind("SUPER + ALT + COMMA", "Invoke last notification", "makoctl invoke")
o.bind("SUPER + SHIFT + ALT + COMMA", "Restore last notification", "makoctl restore")

-- Toggles.
o.bind("SUPER + SHIFT + W", "Toggle weather", o.libexec("omadora-toggle-weather-check"))
o.bind("SUPER + CTRL + I", "Toggle locking on idle", o.libexec("omadora-toggle-idle"))
o.bind("SUPER + CTRL + N", "Toggle nightlight", o.libexec("omadora-toggle-nightlight"))
o.bind(
  "SUPER + CTRL + Delete",
  "Toggle laptop display",
  o.libexec("omadora-hyprland-monitor-internal toggle")
)
o.bind(
  "SUPER + CTRL + ALT + Delete",
  "Toggle laptop display mirroring",
  o.libexec("omadora-hyprland-monitor-internal-mirror toggle")
)
o.bind(
  "switch:on:Lid Switch",
  nil,
  o.libexec("omadora-hw-external-monitors")
    .. " && "
    .. o.libexec("omadora-hyprland-monitor-internal off"),
  { locked = true }
)
o.bind(
  "switch:off:Lid Switch",
  nil,
  o.libexec("omadora-hyprland-monitor-internal on"),
  { locked = true }
)

-- Captures.
o.bind("PRINT", "Screenshot with editing", o.libexec("omadora-capture-screenshot"))
o.bind("ALT + PRINT", "Screenrecording", o.libexec("omadora-menu screenrecord"))
o.bind("SUPER + PRINT", "Color picker", "pkill hyprpicker || hyprpicker -a")
o.bind(
  "SUPER + CTRL + PRINT",
  "Extract text (OCR) from screenshot",
  o.libexec("omadora-capture-text-extraction")
)
-- Not in utilities.conf; keep visible for review.
o.bind("SUPER + CTRL + S", "Share", o.libexec("omadora-menu share"))
-- o.bind("SUPER + CTRL + PERIOD", "Transcode", "omarchy-transcode")

-- Reminders.
o.bind("SUPER + CTRL + R", "Set reminder", o.libexec("omadora-menu reminder-set"))
o.bind("SUPER + CTRL + ALT + R", "Show reminders", o.libexec("omadora-reminder show"))
o.bind("SUPER + SHIFT + CTRL + R", "Clear reminders", o.libexec("omadora-reminder clear"))

-- Waybar-less information.
o.bind(
  "SUPER + CTRL + ALT + T",
  "Show time",
  'notify-send -u low "    $(date +"%A %H:%M  ·  %d %B %Y  ·  Week %V")"'
)
o.bind(
  "SUPER + CTRL + ALT + B",
  "Show battery remaining",
  'notify-send -u low "$(' .. o.libexec("omadora-battery-status") .. ')"'
)
o.bind(
  "SUPER + CTRL + ALT + W",
  "Show weather",
  'notify-send -u low "$(' .. o.libexec("omadora-weather-status") .. ')"'
)

-- Control panels.
o.bind("SUPER + CTRL + A", "Audio controls", o.libexec("omadora-launch-audio"))
o.bind("SUPER + CTRL + B", "Bluetooth controls", o.libexec("omadora-launch-bluetooth"))
o.bind("SUPER + CTRL + W", "Wifi controls", o.libexec("omadora-launch-wifi"))
-- Omarchy launched a btop TUI here; utilities.conf launches Omadora's system monitor.
o.bind("SUPER + CTRL + T", "Activity", o.libexec("omadora-launch-system-monitor"))

-- Zoom.
o.bind(
  "SUPER + CTRL + Z",
  "Zoom in",
  "hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float + 1')"
)
o.bind("SUPER + CTRL + ALT + Z", "Reset zoom", "hyprctl keyword cursor:zoom_factor 1")

-- Lock system.
o.bind("SUPER + CTRL + L", "Lock system", o.libexec("omadora-system-lock"))
