local wezterm = require("wezterm")
local act = wezterm.action

config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt", 
    window_decorations = "RESIZE",
    default_cursor_style = "BlinkingBar",
    color_scheme = "zenwritten_dark",
    font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
    font_size = 10,
}

config.keys = {
    {
      key = 't',
      mods = 'CTRL',
      action = act.SpawnTab 'CurrentPaneDomain'
    },
    {
      key = 'w',
      mods = 'CTRL',
      action = act.CloseCurrentTab{ confirm = true }
    },
  }

return config
