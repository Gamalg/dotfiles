local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 14.0
config.color_scheme = "AdventureTime"
config.window_decorations = "RESIZE"

return config
