-- Application bindings.
o.bind("SUPER + RETURN", "Terminal", { omadora = "terminal" })
o.bind("SUPER + ALT + RETURN", "Tmux", { omadora = "terminal-tmux" })
o.bind("SUPER + SHIFT + RETURN", "Browser", { omadora = "browser" })
o.bind("SUPER + SHIFT + E", "File Explorer", { omadora = "nautilus" })
o.bind("SUPER + ALT + SHIFT + E", "File Explorer (cwd)", { omadora = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omadora = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omadora = "browser --private" })
o.bind("SUPER + SHIFT + N", "Editor", { omadora = "editor" })

-- Web app bindings.
o.bind("SUPER + SHIFT + M", "Google Maps", { webapp = "https://maps.google.com/", focus = true })
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })

-- Add/overwrite extra bindings below.
hl.unbind("SUPER + L")
hl.unbind("SUPER + K")
hl.unbind("SUPER + J")
hl.unbind("SUPER + W")
hl.unbind("SUPER + T")
hl.unbind("SUPER + F")
hl.unbind("SUPER + SHIFT + F")

o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

o.bind("SUPER + Q", "Close window", o.libexec("omadora-hyprland-window-killactive"))
o.bind("SUPER + CTRL + K", "Show key bindings", o.libexec("omadora-menu-keybindings"))
o.bind("SUPER + V", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + F", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + SHIFT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind(
  "SUPER + ALT + L",
  "Toggle workspace layout",
  o.libexec("omadora-hyprland-workspace-layout-toggle")
)
