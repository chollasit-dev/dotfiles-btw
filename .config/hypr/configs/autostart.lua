-- Notifications , status bars, any apps at launch, etc.

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd("udiskie")
  hl.exec_cmd("clipse -listen")
  hl.exec_cmd("waybar")
end)

-- Top-level runs on startup and config reload
hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 32")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme catppuccin-mocha-dark-cursors")

-- GTK3
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-pink-standard+default-xhdpi"')

-- GTK4
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
