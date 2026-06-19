local colors = require('sonokai.colors')
local config = require('sonokai.config')

local M = {}

local function transparent_background()
  local value = config.transparent_background
  if value == true then
    return 1
  end
  if value == false or value == nil then
    return 0
  end
  return value
end

local function to_vim_dict(value)
  if value == nil or (type(value) == 'table' and vim.tbl_isempty(value)) then
    return vim.empty_dict()
  end
  return vim.tbl_deep_extend('force', vim.empty_dict(), value)
end

function M.get_configuration()
  local current_word = config.current_word
  if current_word == nil then
    current_word = transparent_background() == 0 and 'grey background' or 'bold'
  end

  return {
    style = config.style,
    colors_override = to_vim_dict(config.colors_override),
    transparent_background = transparent_background(),
    dim_inactive_windows = config.dim_inactive_windows and 1 or 0,
    disable_italic_comment = config.disable_italic_comment and 1 or 0,
    enable_italic = config.enable_italic and 1 or 0,
    cursor = config.cursor,
    menu_selection_background = config.menu_selection_background,
    spell_foreground = config.spell_foreground,
    show_eob = config.show_eob and 1 or 0,
    float_style = config.float_style,
    current_word = current_word,
    inlay_hints_background = config.inlay_hints_background,
    lightline_disable_bold = config.lightline_disable_bold and 1 or 0,
    diagnostic_text_highlight = config.diagnostic_text_highlight and 1 or 0,
    diagnostic_line_highlight = config.diagnostic_line_highlight and 1 or 0,
    diagnostic_virtual_text = config.diagnostic_virtual_text,
    disable_terminal_colors = config.disable_terminal_colors and 1 or 0,
    better_performance = 0,
  }
end

function M.get_palette(style, colors_override)
  local palette = vim.deepcopy(colors.palettes[style] or colors.palettes.default)
  if type(colors_override) == 'table' and not vim.tbl_isempty(colors_override) then
    for key, value in pairs(colors_override) do
      palette[key] = value
    end
  end
  return palette
end

return M
