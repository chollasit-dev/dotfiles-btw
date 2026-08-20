-----------------
--- AUTOSTART ---
-----------------

-- Notifications daemons, status bars, etc.
-- Or your favorite apps at launch

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd("udiskie")

  hl.exec_cmd("kitty", { workspace = "special:terminal silent" })
  hl.exec_cmd("brave", { workspace = "special:brave silent" })

  hl.exec_cmd("clipse -listen")
  hl.exec_cmd("waybar")
end)

-- Top-level exec_cmd runs on startup and again on every config reload
-- (equivalent of the old `exec =` keyword)
hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 32")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme catppuccin-mocha-dark-cursors")
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-pink-standard+default-xhdpi"') -- GTK3
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark") -- GTK4
