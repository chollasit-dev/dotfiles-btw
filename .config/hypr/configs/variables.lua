---------------------------
--- ENVIRONMENT VARIABLES ---
---------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- NOTE: Program shortcuts ($terminal etc. in the old hyprlang config) are now
-- plain Lua locals defined in the file that uses them, since each require()d
-- file runs in its own scope.

hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
