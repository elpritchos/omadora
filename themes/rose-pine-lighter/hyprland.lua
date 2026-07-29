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
}

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 4,
    border_size = 1,
    col = {
      active_border = palette.active_border,
      inactive_border = palette.inactive_border,
    },
  },

  decoration = {
    rounding = 0,
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

    blur = { enabled = false },
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
      indicator_height = 2,
    },
  },

  misc = {
    background_color = palette.background,
  },
})

hl.layer_rule({
  match = { namespace = "wofi" },
  animation = "popin",
})

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
  speed = 1.4,
  bezier = "rosePineEaseOut",
  style = "fade",
})
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 1,
  bezier = "rosePineEaseIn",
  style = "fade",
})

hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.1, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.8, bezier = "rosePineEaseIn" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 0.9, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 1.4, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.4, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1, bezier = "rosePineEaseIn" })
hl.animation({ leaf = "fadePopupsOut", enabled = true, speed = 0.8, bezier = "rosePineEaseIn" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 1.2, bezier = "rosePineEaseOut" })

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 1.4,
  bezier = "rosePineEaseOut",
  style = "slide",
})
hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 1.8,
  bezier = "rosePineEaseOut",
  style = "slidefadevert 8%",
})
hl.animation({
  leaf = "specialWorkspaceOut",
  enabled = true,
  speed = 1.2,
  bezier = "rosePineEaseIn",
  style = "slidefadevert 8%",
})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 1.2, bezier = "rosePineEaseOut" })
hl.animation({ leaf = "monitorAdded", enabled = true, speed = 1.6, bezier = "rosePineEaseOut" })
