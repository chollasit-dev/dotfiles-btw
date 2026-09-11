-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Best compatibility with any (plug and play)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto-left", scale = 1.2 })

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})

hl.env("GDK_SCALE", "1")
