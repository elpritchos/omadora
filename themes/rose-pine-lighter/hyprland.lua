-- Rose Pine crisp Fluent: light variant.

local palette = {
  active_border = "rgba(56949fe6)",
  inactive_border = "rgba(cecacdaa)",
  background = "rgb(eff1f5)",
  shadow = "rgba(57527933)",
  shadow_inactive = "rgba(5752791a)",
  group_active = "rgba(dfdad9cc)",
  group_inactive = "rgba(eff1f599)",
  text = "rgb(575279)",
  text_inactive = "rgba(57527990)",
  blur_brightness = 1.05,
  blur_contrast = 0.92,
  blur_vibrancy = 0.08,
}

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 1,
    col = {
      active_border = palette.active_border,
      inactive_border = palette.inactive_border,
    },
  },

  decoration = {
    rounding = 0,
    dim_inactive = false,
    dim_special = 0.45,
    dim_around = 0.5,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 4,
      color = palette.shadow,
      color_inactive = palette.shadow_inactive,
      offset = { 0, 2 },
      scale = 0.98,
    },

    blur = {
      enabled = true,
      size = 2,
      passes = 2,
      new_optimizations = true,
      xray = false,
      special = false,
      popups = false,
      noise = 0.01,
      brightness = palette.blur_brightness,
      contrast = palette.blur_contrast,
      vibrancy = palette.blur_vibrancy,
    },
  },

  group = {
    col = {
      border_active = palette.active_border,
      border_inactive = palette.inactive_border,
    },
    groupbar = {
      text_color = palette.text,
      text_color_inactive = palette.text_inactive,
      col = {
        active = palette.group_active,
        inactive = palette.group_inactive,
      },
      gradients = false,
      gradient_rounding = 0,
      gradient_round_only_edges = false,
      indicator_height = 2,
    },
  },

  misc = {
    background_color = palette.background,
  },
})

-- Wofi is translucent only while open, keeping the acrylic treatment inexpensive.
hl.layer_rule({
  match = { namespace = "wofi" },
  no_anim = false,
  blur = true,
  ignore_alpha = 0.2,
  dim_around = true,
  animation = "popin",
})

-- Short, decisive easing keeps the theme polished without delaying interaction.
hl.curve("rosePineEaseOut", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("rosePineEaseIn", { type = "bezier", points = { { 0.32, 0 }, { 0.67, 0 } } })

hl.animation({ leaf = "global", enabled = true, speed = 1.4, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "rosePineEaseOut" })

hl.animation({ leaf = "windows", enabled = true, speed = 1.4, bezier = "rosePineEaseOut" })
hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 1.4,
  bezier = "rosePineEaseOut",
  style = "popin 98%",
})
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 1,
  bezier = "rosePineEaseIn",
  style = "popin 99%",
})
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "rosePineEaseOut" })

hl.animation({
  leaf = "layers",
  enabled = true,
  speed = 1.6,
  bezier = "rosePineEaseOut",
  style = "fade",
})
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 1.6,
  bezier = "rosePineEaseOut",
  style = "fade",
})
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 1.2,
  bezier = "rosePineEaseIn",
  style = "fade",
})

hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.1, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.8, bezier = "rosePineEaseIn" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 0.9, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 1, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 1.6, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.6, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.2, bezier = "rosePineEaseIn" })
hl.animation({ leaf = "fadePopupsIn", enabled = true, speed = 1, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadePopupsOut", enabled = true, speed = 0.8, bezier = "rosePineEaseIn" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 1.2, bezier = "rosePineEaseOut" })

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 1.6,
  bezier = "rosePineEaseOut",
  style = "slidefade 6%",
})
hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 2,
  bezier = "rosePineEaseOut",
  style = "slidefadevert 8%",
})
hl.animation({
  leaf = "specialWorkspaceIn",
  enabled = true,
  speed = 2,
  bezier = "rosePineEaseOut",
  style = "slidefadevert 8%",
})
hl.animation({
  leaf = "specialWorkspaceOut",
  enabled = true,
  speed = 1.4,
  bezier = "rosePineEaseIn",
  style = "slidefadevert 8%",
})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 1.2, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "monitorAdded", enabled = true, speed = 1.6, bezier = "rosePineEaseOut" })
