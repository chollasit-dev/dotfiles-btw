local MOD = "SUPER"
local terminal = "kitty"
local launcher = "fuzzel"
local noti_center = "swaync-client"

--[[
Build a bind key string from space-separated mods, e.g.,

```lua
chord("CTRL SHIFT", "F1") -> "CTRL + SHIFT + F1"
```
]]
local function chord(mods, key)
  if mods == "" then
    return key
  end
  return string.gsub(mods, " ", " + ") .. " + " .. key
end

--[[
Workaround
]]

-- Low-profile keyboard

local dareu_kbd = "dareu-ek868-bt-keyboard"
local lofree = "lofree-flow84"

local low_profile_kbds = { lofree, dareu_kbd } -- TODO: Check device name again

local remaps = {
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

local mod_combos = {
  "",
  "SHIFT",
  "CTRL",
  "ALT",
  "CTRL SHIFT",
  "SHIFT ALT",
  "CTRL ALT",
  "CTRL SHIFT ALT",
}

for _, remap in ipairs(remaps) do
  for _, mods in ipairs(mod_combos) do
    hl.bind(chord(mods, remap[1]), hl.dsp.send_shortcut({ mods = mods, key = remap[2] }), {
      device = {
        -- `true` means include binds for devices below, otherwise exclude
        inclusive = true,
        list = low_profile_kbds,
      },
    })
  end
end

-- Devices specific

local dareu_remaps = {
  { "ALT + Escape", { "", "Escape" } },
  { "Escape", { "", "grave" } },
}

for _, remap in ipairs(dareu_remaps) do
  hl.bind(remap[1], hl.dsp.send_shortcut({ mods = remap[2][1], key = remap[2][2] }), {
    device = {
      -- `true` means include binds for devices below, otherwise exclude
      inclusive = true,
      list = { dareu_kbd },
    },
  })
end

--- Vim-like Keybinds

local function map_vim_key(lhs_mod, lhs_key, rhs_mod, rhs_key, opts)
  local mods = lhs_mod == "" and MOD or MOD .. " " .. lhs_mod
  hl.bind(chord(mods, lhs_key), hl.dsp.send_shortcut({ mods = rhs_mod, key = rhs_key }), opts)
end

map_vim_key("", "M", "", "Return")
map_vim_key("SHIFT", "M", "SHIFT", "Return")
map_vim_key("CTRL", "M", "CTRL", "Return")
map_vim_key("ALT", "M", "ALT", "Return")
map_vim_key("CTRL SHIFT", "M", "CTRL SHIFT", "Return")
map_vim_key("ALT SHIFT", "M", "ALT SHIFT", "Return")
map_vim_key("", "H", "", "Left")
map_vim_key("CTRL", "H", "CTRL", "Left")
map_vim_key("ALT", "H", "ALT", "Left")
map_vim_key("CTRL SHIFT", "H", "CTRL SHIFT", "Left")
map_vim_key("ALT SHIFT", "H", "ALT SHIFT", "Left")
map_vim_key("", "J", "", "Down")
map_vim_key("CTRL", "J", "CTRL", "Down")
map_vim_key("ALT", "J", "ALT", "Down")
map_vim_key("CTRL SHIFT", "J", "CTRL SHIFT", "Down", { repeating = true })
map_vim_key("ALT SHIFT", "J", "ALT SHIFT", "Down")
map_vim_key("", "K", "", "Up")
map_vim_key("CTRL", "K", "CTRL", "Up")
map_vim_key("ALT", "K", "ALT", "Up")
map_vim_key("CTRL SHIFT", "K", "CTRL SHIFT", "Up", { repeating = true })
map_vim_key("ALT SHIFT", "K", "ALT SHIFT", "Up")
map_vim_key("", "L", "", "Right")
map_vim_key("CTRL", "L", "CTRL", "Right")
map_vim_key("ALT", "L", "ALT", "Right")
map_vim_key("CTRL SHIFT", "L", "CTRL SHIFT", "Right")
map_vim_key("ALT SHIFT", "L", "ALT SHIFT", "Right")

map_vim_key("", "B", "CTRL", "Left")
map_vim_key("SHIFT", "B", "CTRL SHIFT", "Left")
map_vim_key("", "W", "CTRL", "Right")
map_vim_key("SHIFT", "W", "CTRL SHIFT", "Right")

map_vim_key("", "0", "", "Home")
map_vim_key("SHIFT", "0", "SHIFT", "Home")
map_vim_key("CTRL", "0", "CTRL", "Home")
map_vim_key("CTRL SHIFT", "0", "CTRL SHIFT", "Home")
map_vim_key("", "E", "", "End")
map_vim_key("SHIFT", "E", "SHIFT", "End")
map_vim_key("CTRL", "E", "CTRL", "End")
map_vim_key("CTRL SHIFT", "E", "CTRL SHIFT", "End")

map_vim_key("", "P", "", "Prior")
map_vim_key("SHIFT", "P", "SHIFT", "Prior")
map_vim_key("CTRL", "P", "CTRL", "Prior")
map_vim_key("CTRL SHIFT", "P", "CTRL SHIFT", "Prior", { repeating = true })
map_vim_key("", "N", "", "Next")
map_vim_key("SHIFT", "N", "SHIFT", "Next")
map_vim_key("CTRL", "N", "CTRL", "Next")
map_vim_key("CTRL SHIFT", "N", "CTRL SHIFT", "Next", { repeating = true })

map_vim_key("", "X", "", "Delete")
map_vim_key("SHIFT", "X", "", "BackSpace")
map_vim_key("CTRL", "X", "CTRL", "Delete")
map_vim_key("", "bracketleft", "", "Escape")

----------------
--- Programs ---
----------------

hl.bind(MOD .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(MOD .. " + T", hl.dsp.exec_cmd(terminal .. " -T '󰂯 Bluetui' zsh -c bluetui"))
hl.bind(MOD .. " + SHIFT + T", hl.dsp.exec_cmd(terminal .. " -T '󰤥  Network Manager TUI' zsh -c nmtui"))
hl.bind(MOD .. " + V", hl.dsp.exec_cmd(terminal .. " --class=clipse -T '󰅇  Clipse' zsh -c clipse"))
hl.bind(MOD .. " + R", hl.dsp.exec_cmd(launcher))
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

--[[ Workspaces ]]

-- Action
hl.bind(MOD .. " + C", hl.dsp.window.close())
hl.bind(MOD .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(MOD .. " + slash", hl.dsp.exec_cmd(noti_center .. " -t -sw"))
hl.bind(MOD .. " + Space", hl.dsp.cursor.move_to_corner({ corner = 1 })) -- Bottom right
hl.bind(MOD .. " + SHIFT + Space", hl.dsp.window.center())

for i = 1, 9 do
  hl.bind(MOD .. " + " .. i, function()
    hl.dispatch(hl.dsp.focus({ workspace = i }))
  end)
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
