---@class SonokaiConfig
---@field style string
---@field colors_override table<string, string[]>
---@field transparent_background boolean|integer
---@field dim_inactive_windows boolean
---@field disable_italic_comment boolean
---@field enable_italic boolean
---@field cursor string
---@field menu_selection_background string
---@field spell_foreground string
---@field show_eob boolean
---@field float_style string
---@field current_word string|nil
---@field inlay_hints_background string
---@field lightline_disable_bold boolean
---@field diagnostic_text_highlight boolean
---@field diagnostic_line_highlight boolean
---@field diagnostic_virtual_text string
---@field disable_terminal_colors boolean
---@field overrides table|function
---@field terminal boolean

local config = {
  defaults = {
    style = 'default',
    colors_override = {},
    transparent_background = false,
    dim_inactive_windows = false,
    disable_italic_comment = false,
    enable_italic = false,
    cursor = '',
    menu_selection_background = 'blue',
    spell_foreground = 'none',
    show_eob = true,
    float_style = 'bright',
    current_word = nil,
    inlay_hints_background = 'none',
    lightline_disable_bold = false,
    diagnostic_text_highlight = false,
    diagnostic_line_highlight = false,
    diagnostic_virtual_text = 'grey',
    disable_terminal_colors = false,
    terminal = true,
    overrides = {},
  },
}

setmetatable(config, { __index = config.defaults })

return config
