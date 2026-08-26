-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
   general = {
     -- No gaps between windows or borders.
     gaps_in = 2,
     gaps_out = 2,
     border_size = 2,
     -- Change to niri-like side-scrolling layout.
     -- layout = "master",
   },

  decoration = {
    -- Use round window corners.
    rounding = 4,

    -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
    dim_inactive = true,
    dim_strength = 0.15,
    active_opacity = 1.0,
  },

  xwayland = {
    force_zero_scaling = true,
  },

  misc = {
    font_family = "Iosevka",
  },

  group = {
    groupbar = {
      font_size = 14,
    },
  },
})

