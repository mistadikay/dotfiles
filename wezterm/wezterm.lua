local wezterm = require("wezterm")
local act = wezterm.action

config = wezterm.config_builder()
config.automatically_reload_config = true

-- Tabs and windows
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

-- Colors and fonts
config.default_cursor_style = "BlinkingBar"
config.color_scheme = "Afterglow"
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 10
config.window_frame = {
  font = wezterm.font({ family = 'JetBrains Mono', weight = 'Regular' }),
  font_size = 10,
}

-- Some remappings for linux
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


local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  local gradient_to, gradient_from = bg, bg
  gradient_from = gradient_to:lighten(0.2)
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
