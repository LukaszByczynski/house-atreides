-- Personal window rules and workspace layout.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Steam: let its windows exceed the max-size clamp and keep it tiled.
o.window({ class = "steam", title = "Steam" }, { no_max_size = true })
o.window({ class = "steam", title = "Friends List" }, { no_max_size = true })
o.window("steam", { float = false })
o.window({ initial_class = "^(steam).*" }, { workspace = "6" })
-- o.window("steam", { workspace = "4" })
o.window("steam", { opacity = "1 1" })
o.window("steam", { idle_inhibit = "fullscreen" })
o.window("steam", { no_initial_focus = true })
o.window({ class = "steam", title = "^(notificationtoasts).*" }, { no_focus = true })
o.window("steam_app_.*", { idle_inhibit = "fullscreen" })
o.window({ initial_class = "^(steam).*" }, { idle_inhibit = "fullscreen" })

-- Custom layout: Slack is always the left column, 30% wide; every other
-- window shares the right 70%, stacked top to bottom.
local SLACK_RATIO = 0.3
hl.layout.register("slack_left", {
  recalculate = function(ctx)
    local slack, rest = nil, {}
    for _, target in ipairs(ctx.targets) do
      if target.window and target.window.class == "com.slack.Slack" then
        slack = target
      else
        table.insert(rest, target)
      end
    end

    if not slack then
      for i, target in ipairs(rest) do
        target:place(ctx:row(i, #rest))
      end
      return
    end

    local left = ctx:split(ctx.area, "left", SLACK_RATIO)
    slack:place(left)
    if #rest == 0 then
      return
    end
    local right = {
      x = ctx.area.x + left.w,
      y = ctx.area.y,
      w = ctx.area.w - left.w,
      h = ctx.area.h,
    }
    for i, target in ipairs(rest) do
      target:place({ x = right.x, y = right.y + (i - 1) * right.h / #rest, w = right.w, h = right.h / #rest })
    end
  end,
})
-- Omarchy's saved per-workspace layout (dwindle) is applied after this file
-- loads and would win, so set the rule again once the config has settled.
local function use_slack_layout()
  hl.workspace_rule({ workspace = "1", layout = "lua:slack_left" })
end
use_slack_layout()
hl.timer(use_slack_layout, { type = "oneshot", timeout = 500 })

o.window("^firefox.*", { workspace = "1" })
o.window({ tag = "floating-window" }, { size = { 1920, 1080 } })

o.window("net.nokyan.Resources", { float = true })

-- Apps that open on their workspace without taking focus, now or on later activation requests.
local silent_windows = {
  { match = { class = "^(window)$" }, workspace = "4" },
  { match = "com.slack.Slack", workspace = "1" },
  { match = "Spotify", workspace = "3" },
  { match = "org.mozilla.Thunderbird", workspace = "2" },
  { match = "brave-browser", workspace = "5" },
}
for _, w in ipairs(silent_windows) do
  o.window(w.match, {
    workspace = w.workspace .. " silent",
    no_initial_focus = true,
    suppress_event = "activate activatefocus",
  })
end
