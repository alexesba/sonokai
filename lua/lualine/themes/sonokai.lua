local config = require('sonokai.config')
local colors = require('sonokai.colors')

local palette = vim.deepcopy(colors.palettes[config.style] or colors.palettes.default)
if config.colors_override then
  for key, value in pairs(config.colors_override) do
    palette[key] = value
  end
end

local transparent = config.transparent_background
if transparent == true then
  transparent = 1
elseif transparent == false or transparent == nil then
  transparent = 0
end

if transparent == 2 then
  palette.bg1 = palette.none
end

local bold = not config.lightline_disable_bold and 'bold' or nil

return {
  normal = {
    a = { bg = palette.filled_blue[1], fg = palette.bg0[1], gui = bold },
    b = { bg = palette.bg4[1], fg = palette.fg[1] },
    c = { bg = palette.bg1[1], fg = palette.fg[1] },
  },
  insert = {
    a = { bg = palette.filled_green[1], fg = palette.bg0[1], gui = bold },
    b = { bg = palette.bg4[1], fg = palette.fg[1] },
    c = { bg = palette.bg1[1], fg = palette.fg[1] },
  },
  visual = {
    a = { bg = palette.filled_red[1], fg = palette.bg0[1], gui = bold },
    b = { bg = palette.bg4[1], fg = palette.fg[1] },
    c = { bg = palette.bg1[1], fg = palette.fg[1] },
  },
  replace = {
    a = { bg = palette.orange[1], fg = palette.bg0[1], gui = bold },
    b = { bg = palette.bg4[1], fg = palette.fg[1] },
    c = { bg = palette.bg1[1], fg = palette.fg[1] },
  },
  command = {
    a = { bg = palette.yellow[1], fg = palette.bg0[1], gui = bold },
    b = { bg = palette.bg4[1], fg = palette.fg[1] },
    c = { bg = palette.bg1[1], fg = palette.fg[1] },
  },
  terminal = {
    a = { bg = palette.purple[1], fg = palette.bg0[1], gui = bold },
    b = { bg = palette.bg3[1], fg = palette.fg[1] },
    c = { bg = palette.bg1[1], fg = palette.fg[1] },
  },
  inactive = {
    a = { bg = palette.bg1[1], fg = palette.grey[1] },
    b = { bg = palette.bg1[1], fg = palette.grey[1] },
    c = { bg = palette.bg1[1], fg = palette.grey[1] },
  },
}
