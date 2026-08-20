---------------
--- WINDOWS ---
---------------

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
  name = "windowrule-floating",
  match = { float = true },
  border_size = 2,
  center = true,
  rounding = 10,
})

hl.window_rule({
  name = "windowrule-clipse",
  match = { class = "clipse" },
  center = true,
  float = true,
  pin = true,
  size = { 622, 652 },
})

hl.window_rule({
  name = "windowrule-xwayland",
  match = { xwayland = true },
  border_color = { colors = { "rgba(74c7ecee)", "rgba(89b4faff)" }, angle = 45 },
  no_follow_mouse = true,
})
