-- Personal window rules and workspace layout.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Steam: let its windows exceed the max-size clamp and keep it tiled.
o.window({ class = "steam", title = "Steam" }, { no_max_size = true })
o.window({ class = "steam", title = "Friends List" }, { no_max_size = true })
o.window("steam", { float = false })
o.window({ initial_class = "^(steam).*" }, { workspace = "6" })
o.window("steam", { workspace = "5" })
o.window("steam", { opacity = "1 1" })
o.window("steam", { idle_inhibit = "fullscreen" })
o.window("steam", { no_initial_focus = true })
o.window({ class = "steam", title = "^(notificationtoasts).*" }, { no_focus = true })

o.window({ class = "^(window)$" }, { workspace = "5 silent" })

-- Master layout on workspace 0.
hl.config({
  master = {
    mfact = 0.3,
    orientation = "left",
    new_status = "slave",
  },
})
hl.workspace_rule({ workspace = "0", layout = "master" })

o.window("firefox-esr", { workspace = "0" })
o.window("com.slack.Slack", { workspace = "0 silent" })
o.window({ tag = "floating-window" }, { size = { 1920, 1080 } })

o.window("Spotify", { workspace = "2" })
o.window("thunderbird-esr", { workspace = "2" })
o.window("net.nokyan.Resources", { float = true })
o.window("brave-browser", { workspace = "5" })
