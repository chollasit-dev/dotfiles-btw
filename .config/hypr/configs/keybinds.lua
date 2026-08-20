----------------
--- KEYBINDS ---
----------------

-- https://wiki.hypr.land/Configuring/Basics/Binds/

local MOD = "SUPER"

local terminal = "kitty"
local menu = "fuzzel"
local notiCenter = "swaync-client"

-- Builds a bind key string from space-separated mods, e.g.
-- chord("CTRL SHIFT", "F1") -> "CTRL + SHIFT + F1"
local function chord(mods, key)
  if mods == "" then
    return key
  end
  return (mods:gsub(" ", " + ")) .. " + " .. key
end

--------------------
--- HACK: Global ---
--------------------

-- TODO: Move this under this specific devices.

local fnRemaps = {
  { "XF86MonBrightnessDown", "F1" },
  { "XF86MonBrightnessUp", "F2" },
  { "XF86LaunchA", "F3" },
  { "XF86LaunchB", "F4" },
  { "XF86KbdBrightnessDown", "F5" },
  { "XF86KbdBrightnessUp", "F6" },
  { "XF86AudioPrev", "F7" },
  { "XF86AudioPlay", "F8" },
  { "XF86AudioNext", "F9" },
  { "XF86AudioMute", "F10" },
  { "XF86AudioLowerVolume", "F11" },
  { "XF86AudioRaiseVolume", "F12" },
}
local modCombos = { "", "SHIFT", "CTRL", "ALT", "CTRL SHIFT", "SHIFT ALT", "CTRL SHIFT ALT" }

for _, remap in ipairs(fnRemaps) do
  for _, mods in ipairs(modCombos) do
    hl.bind(chord(mods, remap[1]), hl.dsp.send_shortcut({ mods = mods, key = remap[2] }))
  end
end

-------------
--- HACK: ---
-------------

-- Kitty

for _, key in ipairs({ "Up", "Down", "Prior", "Next", "Home", "End" }) do
  hl.bind(
    chord("CTRL SHIFT", "KP_" .. key),
    hl.dsp.send_shortcut({
      mods = "CTRL SHIFT",
      key = key,
      window = "class:^(kitty)$",
    })
  )
end

-- Firefox

for _, key in ipairs({ "Prior", "Next" }) do
  hl.bind(
    chord("CTRL SHIFT", "KP_" .. key),
    hl.dsp.send_shortcut({
      mods = "CTRL SHIFT",
      key = key,
      window = "class:^(firefox)$",
    })
  )
end

-------------------------
--- Vim-like Keybinds ---
-------------------------

local function vimKey(lhsMods, lhsKey, rhsMods, rhsKey, opts)
  local mods = lhsMods == "" and MOD or MOD .. " " .. lhsMods
  hl.bind(chord(mods, lhsKey), hl.dsp.send_shortcut({ mods = rhsMods, key = rhsKey }), opts)
end

vimKey("", "M", "", "Return")
vimKey("SHIFT", "M", "SHIFT", "Return")
vimKey("CTRL", "M", "CTRL", "Return")
vimKey("ALT", "M", "ALT", "Return")
vimKey("CTRL SHIFT", "M", "CTRL SHIFT", "Return")
vimKey("ALT SHIFT", "M", "ALT SHIFT", "Return")
-- vimKey("", "H", "", "Left")
vimKey("CTRL", "H", "CTRL", "Left")
vimKey("ALT", "H", "ALT", "Left")
vimKey("CTRL SHIFT", "H", "CTRL SHIFT", "Left")
vimKey("ALT SHIFT", "H", "ALT SHIFT", "Left")
vimKey("", "J", "", "Down")
vimKey("CTRL", "J", "CTRL", "Down")
vimKey("ALT", "J", "ALT", "Down")
vimKey("CTRL SHIFT", "J", "CTRL SHIFT", "Down", { repeating = true })
vimKey("ALT SHIFT", "J", "ALT SHIFT", "Down")
vimKey("", "K", "", "Up")
vimKey("CTRL", "K", "CTRL", "Up")
vimKey("ALT", "K", "ALT", "Up")
vimKey("CTRL SHIFT", "K", "CTRL SHIFT", "Up", { repeating = true })
vimKey("ALT SHIFT", "K", "ALT SHIFT", "Up")
vimKey("", "L", "", "Right")
vimKey("CTRL", "L", "CTRL", "Right")
vimKey("ALT", "L", "ALT", "Right")
vimKey("CTRL SHIFT", "L", "CTRL SHIFT", "Right")
vimKey("ALT SHIFT", "L", "ALT SHIFT", "Right")

vimKey("", "B", "CTRL", "Left")
vimKey("SHIFT", "B", "CTRL SHIFT", "Left")
vimKey("", "W", "CTRL", "Right")
vimKey("SHIFT", "W", "CTRL SHIFT", "Right")

vimKey("", "0", "", "Home")
vimKey("SHIFT", "0", "SHIFT", "Home")
vimKey("CTRL", "0", "CTRL", "Home")
vimKey("CTRL SHIFT", "0", "CTRL SHIFT", "Home")
vimKey("", "E", "", "End")
vimKey("SHIFT", "E", "SHIFT", "End")
vimKey("CTRL", "E", "CTRL", "End")
vimKey("CTRL SHIFT", "E", "CTRL SHIFT", "End")

vimKey("", "P", "", "Prior")
vimKey("SHIFT", "P", "SHIFT", "Prior")
vimKey("CTRL", "P", "CTRL", "Prior")
vimKey("CTRL SHIFT", "P", "CTRL SHIFT", "Prior", { repeating = true })
vimKey("", "N", "", "Next")
vimKey("SHIFT", "N", "SHIFT", "Next")
vimKey("CTRL", "N", "CTRL", "Next")
vimKey("CTRL SHIFT", "N", "CTRL SHIFT", "Next", { repeating = true })

vimKey("", "X", "", "Delete")
vimKey("SHIFT", "X", "", "BackSpace")
vimKey("", "H", "", "BackSpace")
vimKey("CTRL", "X", "CTRL", "Delete")
vimKey("", "bracketleft", "", "Escape")

----------------
--- Programs ---
----------------

hl.bind(MOD .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(MOD .. " + T", hl.dsp.exec_cmd(terminal .. " -T '󰂯 Bluetui' zsh -c bluetui"))
hl.bind(MOD .. " + SHIFT + T", hl.dsp.exec_cmd(terminal .. " -T '󰤥  Network Manager TUI' zsh -c nmtui"))
hl.bind(MOD .. " + V", hl.dsp.exec_cmd(terminal .. " --class=clipse -T '󰅇  Clipse' zsh -c clipse"))
hl.bind(MOD .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(MOD .. " + period", hl.dsp.exec_cmd("bemoji -t"))
hl.bind(MOD .. " + I", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(MOD .. " + Print", hl.dsp.exec_cmd('~/.config/hypr/scripts/basic_screenshot.bash "fullscreen"'))
hl.bind(MOD .. " + SHIFT + Print", hl.dsp.exec_cmd('~/.config/hypr/scripts/basic_screenshot.bash "selection"'))
hl.bind(MOD .. " + ALT + Print", hl.dsp.exec_cmd('~/.config/hypr/scripts/basic_screenshot.bash "annotation"'))
hl.bind(MOD .. " + CTRL + Print", hl.dsp.exec_cmd('~/.config/hypr/scripts/wf_recorder.bash "fullscreen"'))
hl.bind(MOD .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd('~/.config/hypr/scripts/wf_recorder.bash "selection"'))

-----------------------
--- Windows manager ---
-----------------------

-- Focus
hl.bind(MOD .. " + SHIFT + H", hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + SHIFT + L", hl.dsp.focus({ direction = "right" }))
hl.bind(MOD .. " + SHIFT + K", hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + SHIFT + J", hl.dsp.focus({ direction = "down" }))
hl.bind(MOD .. " + TAB", hl.dsp.window.cycle_next())

-- Resize
hl.bind(MOD .. " + minus", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(MOD .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
hl.bind(MOD .. " + SHIFT + comma", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(MOD .. " + SHIFT + period", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(MOD .. " + F", hl.dsp.window.fullscreen())

-- Layout
hl.bind(MOD .. " + backslash", function()
  local layout = hl.get_config("general.layout")
  hl.config({ general = { layout = layout == "dwindle" and "master" or "dwindle" } })
end)

-- Zoom
hl.bind(MOD .. " + mouse_down", function()
  hl.config({ cursor = { zoom_factor = hl.get_config("cursor.zoom_factor") * 1.1 } })
end)
hl.bind(MOD .. " + mouse_up", function()
  hl.config({ cursor = { zoom_factor = math.max(hl.get_config("cursor.zoom_factor") * 0.9, 1) } })
end)
hl.bind(MOD .. " + CTRL + 0", function()
  hl.config({ cursor = { zoom_factor = 1 } })
end)

------------------
--- Workspaces ---
------------------

-- Action
hl.bind(MOD .. " + C", hl.dsp.window.close())
hl.bind(MOD .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(MOD .. " + SHIFT + bracketleft", function()
  -- Double toggle pulls the open special workspace onto the focused monitor
  hl.dispatch(hl.dsp.workspace.toggle_special())
  hl.dispatch(hl.dsp.workspace.toggle_special())
end)
hl.bind(MOD .. " + slash", hl.dsp.exec_cmd(notiCenter .. " -t -sw"))
hl.bind(MOD .. " + Space", hl.dsp.cursor.move_to_corner({ corner = 1 })) -- Bottom right
hl.bind(MOD .. " + SHIFT + Space", hl.dsp.window.center())

for i = 1, 9 do
  hl.bind(MOD .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(MOD .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

---------------
--- Monitor ---
---------------

hl.bind(MOD .. " + SHIFT + TAB", hl.dsp.focus({ monitor = "+1" }))
hl.bind(MOD .. " + CTRL + TAB", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(MOD .. " + CTRL + SHIFT + TAB", hl.dsp.window.move({ monitor = "-1" }))

-- NOTE: Direct DPMS dispatches may cause glitches; delay them with a timer
hl.bind("switch:on:[lid switch]", function()
  hl.monitor({ output = "eDP-1", disabled = true })
  hl.timer(function()
    hl.dispatch(hl.dsp.dpms({ action = "disable", monitor = "eDP-1" }))
  end, { timeout = 1000, type = "oneshot" })
end, { locked = true })
hl.bind("switch:off:[lid switch]", function()
  hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto-left", scale = 1.2 })
  hl.timer(function()
    hl.dispatch(hl.dsp.dpms({ action = "enable", monitor = "eDP-1" }))
  end, { timeout = 1000, type = "oneshot" })
end, { locked = true })

------------------
--- Multimedia ---
------------------

hl.bind(
  MOD .. " + XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
  { locked = true, repeating = true }
)
hl.bind(
  MOD .. " + XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
  { locked = true, repeating = true }
)
hl.bind(
  MOD .. " + XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
  { locked = true, repeating = true }
)
hl.bind(
  MOD .. " + XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
  { locked = true, repeating = true }
)

hl.bind(MOD .. " + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind(MOD .. " + Insert", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind(MOD .. " + XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(MOD .. " + XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(MOD .. " + XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-------------------------
--- Special workspace ---
-------------------------

local specials = {
  { "A", "terminal" },
  { "Y", "brave" },
  { "D", "discord" },
  { "S", "scratchpad" },
  { "G", "game" },
}

for _, special in ipairs(specials) do
  hl.bind(MOD .. " + " .. special[1], hl.dsp.workspace.toggle_special(special[2]))
  hl.bind(MOD .. " + SHIFT + " .. special[1], hl.dsp.window.move({ workspace = "special:" .. special[2] }))
end

-------------
--- Debug ---
-------------

-- hl.bind(MOD .. " + W", hl.dsp.exec_cmd("pkill waybar; waybar"))
-- hl.bind(MOD .. " + SHIFT + W", hl.dsp.exec_cmd(notiCenter .. " -R && " .. notiCenter .. " -rs && notify-send 'Swaync' 'Configuration and style reloaded'"))
