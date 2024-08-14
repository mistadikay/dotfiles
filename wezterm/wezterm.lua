local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt", 
    window_decoration = "RESIZE",
    default_cursor_style = "BlinkingBar",
    color_scheme = "zenwritten_dark",
    font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
    font_size = 10,
}

return config
