-- Extra environment variable overrides.

-- Let Electron auto-detect Wayland/X11 instead of forcing Wayland.
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
