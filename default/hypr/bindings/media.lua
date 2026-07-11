-- Volume, brightness, keyboard backlight, and touchpad controls.
o.bind(
  "XF86AudioRaiseVolume",
  "Volume up",
  o.libexec("omadora-audio-output-volume raise"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86AudioLowerVolume",
  "Volume down",
  o.libexec("omadora-audio-output-volume lower"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86AudioMute",
  "Mute",
  o.libexec("omadora-audio-output-volume mute-toggle"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86AudioMicMute",
  "Mute microphone",
  o.libexec("omadora-audio-input-mute"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86MonBrightnessUp",
  "Brightness up",
  o.libexec("omadora-brightness-display +5%"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86MonBrightnessDown",
  "Brightness down",
  o.libexec("omadora-brightness-display 5%-"),
  { locked = true, repeating = true }
)
o.bind(
  "SHIFT + XF86MonBrightnessUp",
  "Brightness maximum",
  o.libexec("omadora-brightness-display 100%"),
  { locked = true, repeating = true }
)
o.bind(
  "SHIFT + XF86MonBrightnessDown",
  "Brightness minimum",
  o.libexec("omadora-brightness-display 1%"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86KbdBrightnessUp",
  "Keyboard brightness up",
  o.libexec("omadora-brightness-keyboard up"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86KbdBrightnessDown",
  "Keyboard brightness down",
  o.libexec("omadora-brightness-keyboard down"),
  { locked = true, repeating = true }
)
o.bind(
  "XF86KbdLightOnOff",
  "Keyboard backlight cycle",
  o.libexec("omadora-brightness-keyboard cycle"),
  { locked = true }
)
o.bind(
  "XF86TouchpadToggle",
  "Toggle touchpad",
  o.libexec("omadora-toggle-touchpad"),
  { locked = true }
)
o.bind(
  "XF86TouchpadOn",
  "Enable touchpad",
  o.libexec("omadora-toggle-touchpad on"),
  { locked = true }
)
o.bind(
  "XF86TouchpadOff",
  "Disable touchpad",
  o.libexec("omadora-toggle-touchpad off"),
  { locked = true }
)

-- Media controls.
o.bind("XF86AudioPlay", "Play", "playerctl play-pause", { locked = true })
o.bind("XF86AudioPause", "Pause", "playerctl pause", { locked = true })
o.bind("XF86AudioNext", "Next track", "playerctl next", { locked = true })
o.bind("XF86AudioPrev", "Previous track", "playerctl previous", { locked = true })

o.bind(
  "SUPER + XF86AudioMute",
  "Switch audio output",
  o.libexec("omadora-audio-output-switch"),
  { locked = true }
)
