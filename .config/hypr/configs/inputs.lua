-- https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
  input = {
    kb_layout = "us,th",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:caps_toggle",
    kb_rules = "",

    follow_mouse = 1,

    -- Mouse
    emulate_discrete_scroll = 2,

    touchpad = {
      natural_scroll = true,
    },
  },
})

-- Per-device
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

-- PC

hl.device({
  name = "lxd-2.4g-mouse-1",
  sensitivity = -0.75,
})

-- Laptop

hl.device({
  name = "syna2ba6:00-06cb:cefe-touchpad",
  enabled = true,
  sensitivity = -0.25,
})
