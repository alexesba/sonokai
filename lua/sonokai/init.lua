local colors = require('sonokai.colors')
local config = require('sonokai.config')
local sonokai = {}

local plugin_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':h:h:h')

local function to_vim_dict(value)
  if value == nil or (type(value) == 'table' and vim.tbl_isempty(value)) then
    return vim.empty_dict()
  end
  return vim.tbl_deep_extend('force', vim.empty_dict(), value)
end

local function transparent_background_value(value)
  if value == true then
    return 1
  end
  if value == false or value == nil then
    return 0
  end
  return value
end

--- Sync Lua config to legacy g: variables used by colors/sonokai.vim.
local function sync_legacy_globals()
  local transparent = transparent_background_value(config.transparent_background)
  local current_word = config.current_word
  if current_word == nil then
    current_word = transparent == 0 and 'grey background' or 'bold'
  end

  vim.g.sonokai_style = config.style
  vim.g.sonokai_colors_override = to_vim_dict(config.colors_override)
  vim.g.sonokai_transparent_background = transparent
  vim.g.sonokai_dim_inactive_windows = config.dim_inactive_windows and 1 or 0
  vim.g.sonokai_disable_italic_comment = config.disable_italic_comment and 1 or 0
  vim.g.sonokai_enable_italic = config.enable_italic and 1 or 0
  vim.g.sonokai_cursor = config.cursor
  vim.g.sonokai_menu_selection_background = config.menu_selection_background
  vim.g.sonokai_spell_foreground = config.spell_foreground
  vim.g.sonokai_show_eob = config.show_eob and 1 or 0
  vim.g.sonokai_float_style = config.float_style
  vim.g.sonokai_current_word = current_word
  vim.g.sonokai_inlay_hints_background = config.inlay_hints_background
  vim.g.sonokai_lightline_disable_bold = config.lightline_disable_bold and 1 or 0
  vim.g.sonokai_diagnostic_text_highlight = config.diagnostic_text_highlight and 1 or 0
  vim.g.sonokai_diagnostic_line_highlight = config.diagnostic_line_highlight and 1 or 0
  vim.g.sonokai_diagnostic_virtual_text = config.diagnostic_virtual_text
  vim.g.sonokai_disable_terminal_colors = config.disable_terminal_colors and 1 or 0
  vim.g.sonokai_better_performance = 0
end

local function apply_overrides()
  local overrides = type(config.overrides) == 'function' and config.overrides() or config.overrides
  if type(overrides) ~= 'table' then
    return
  end

  for group, parameters in pairs(overrides) do
    vim.api.nvim_set_hl(0, group, parameters)
  end
end

local function set_terminal_colors(palette)
  vim.g.terminal_color_0 = palette.black[1]
  vim.g.terminal_color_1 = palette.red[1]
  vim.g.terminal_color_2 = palette.green[1]
  vim.g.terminal_color_3 = palette.yellow[1]
  vim.g.terminal_color_4 = palette.blue[1]
  vim.g.terminal_color_5 = palette.purple[1]
  vim.g.terminal_color_6 = palette.orange[1]
  vim.g.terminal_color_7 = palette.fg[1]
  vim.g.terminal_color_8 = palette.grey[1]
  vim.g.terminal_color_9 = palette.red[1]
  vim.g.terminal_color_10 = palette.green[1]
  vim.g.terminal_color_11 = palette.yellow[1]
  vim.g.terminal_color_12 = palette.blue[1]
  vim.g.terminal_color_13 = palette.purple[1]
  vim.g.terminal_color_14 = palette.orange[1]
  vim.g.terminal_color_15 = palette.fg[1]
end

---@param values table|nil
function sonokai.setup(values)
  setmetatable(config, { __index = vim.tbl_extend('force', config.defaults, values or {}) })
end

---@param style string|nil
function sonokai.colorscheme(style)
  if style then
    config.style = style
  end

  sync_legacy_globals()
  colors.generate(config.style, config.colors_override)

  vim.o.termguicolors = true
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
  end

  local palette = colors.palettes[config.style] or colors.palettes.default
  local merged_palette = vim.tbl_extend('force', palette, config.colors_override or {})
  if config.terminal and not config.disable_terminal_colors then
    set_terminal_colors(merged_palette)
  end

  vim.g.sonokai_use_lua_highlights = 1
  require('sonokai.highlights').set_groups()

  -- legacy.vim is kept for compatibility hooks only.
  vim.cmd('source ' .. plugin_root .. '/lua/sonokai/legacy.vim')

  local colors_name = config.style == 'default' and 'sonokai' or ('sonokai-' .. config.style)
  vim.g.colors_name = colors_name

  apply_overrides()
end

return sonokai
