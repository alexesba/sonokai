local colors = require('sonokai.colors')
local config = require('sonokai.config')
local sonokai = {}

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

  require('sonokai.highlights').set_groups()

  vim.g.colors_name = config.style == 'default' and 'sonokai' or ('sonokai-' .. config.style)

  apply_overrides()
end

return sonokai
