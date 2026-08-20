-- https://wiki.hypr.land/Configuring/

require("configs/variables") -- NOTE: Import first
require("configs/keybinds")
require("configs/windows")
require("configs/workspaces")
require("configs/autostart")

----------------
--- MONITORS ---
----------------

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

-------------------
--- PERMISSIONS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Changes require a Hyprland to restart and are not applied on-the-fly for
-- security reasons

hl.config({
  ecosystem = {
    no_donation_nag = true,
  },
})

-- hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })

---------------------
--- LOOK AND FEEL ---
---------------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    border_size = 1,

    col = {
      -- catppuccin mocha
      active_border = { colors = { "rgba(f5c2e7ee)", "rgba(cba6f7ff)" }, angle = 45 },
      inactive_border = "rgba(7f849cdd)",
    },

    float_gaps = 0,
    gaps_in = -1,
    gaps_out = -1,

    snap = {
      enabled = true,
      border_overlap = true,
    },

    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before turn this on.
    allow_tearing = false,

    layout = "dwindle",
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    dim_inactive = true,
    dim_modal = true,
    dim_special = 0.375,
    dim_strength = 0.05,

    rounding = 0,
    rounding_power = 4,

    blur = {
      enabled = false,
      input_methods = true,
      new_optimizations = true,
      passes = 1,
      size = 2,
      special = true,
      vibrancy = 0.1696,
      xray = true,
    },

    shadow = {
      enabled = true,
      color = "rgba(1a1a1aee)",
      range = 4,
      render_power = 4,
    },
  },

  animations = {
    enabled = false,
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.config({
  -- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
  master = {
    new_status = "master",
  },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
  misc = {
    animate_manual_resizes = true,
    animate_mouse_windowdragging = true,
    disable_hyprland_logo = false, -- Disables random hyprland logo/anime background
    focus_on_activate = true,
    force_default_wallpaper = 2, -- Anime girl
    key_press_enables_dpms = true,
    mouse_move_focuses_monitor = false,
    vrr = 1,
  },

  cursor = {
    inactive_timeout = 10,
    no_warps = true,
  },

  quirks = {
    prefer_hdr = 1,
  },
})

-------------
--- INPUT ---
-------------

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

-- Per-device config.
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

hl.device({
  name = "syna2ba6:00-06cb:cefe-mouse",
  enabled = false,
  sensitivity = -0.75,
})

hl.device({
  name = "syna2ba6:00-06cb:cefe-touchpad",
  enabled = true,
  sensitivity = -0.25,
})
