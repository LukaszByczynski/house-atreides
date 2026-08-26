-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Second Activity shortcut (default lives on SUPER+CTRL+T).
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Extra screenshot binding (region + windows copy on the same key).
o.bind("CTRL + SHIFT + 4", "Screenshot", "omarchy-capture-screenshot region copy")
o.bind("CTRL + SHIFT + 4", "Screenshot", "omarchy-capture-screenshot windows copy")

-- nvibrant toggles.
o.bind("SUPER + SHIFT + V", "nvibrant on", "nvibrant 0 0 0 0 0 256")

-- SUPER+SHIFT+C was previously bound to Calendar (webapp). Unbound to reuse
-- the key for nvibrant off.
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "nvibrant off", "nvibrant")
