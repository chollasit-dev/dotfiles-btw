------------------
--- WORKSPACES ---
------------------

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local terminal = "kitty"

hl.workspace_rule({ workspace = "special:terminal", on_created_empty = terminal })
hl.workspace_rule({ workspace = "special:discord", on_created_empty = "discord" })
