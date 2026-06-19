local M = {}

---@param style string|nil
---@return table
function M.parse_style(style)
  if not style or style == 'NONE' then
    return {}
  end

  local attrs = {}
  for attr in string.gmatch(style, '[^,]+') do
    attr = vim.trim(attr)
    if attr == 'bold' then
      attrs.bold = true
    elseif attr == 'italic' then
      attrs.italic = true
    elseif attr == 'underline' then
      attrs.underline = true
    elseif attr == 'undercurl' then
      attrs.undercurl = true
    elseif attr == 'reverse' then
      attrs.reverse = true
    elseif attr == 'strikethrough' then
      attrs.strikethrough = true
    elseif attr == 'nocombine' then
      attrs.nocombine = true
    end
  end
  return attrs
end

---@param fg string|nil
---@param bg string|nil
---@param style string|nil
---@param sp string|nil
---@return table
function M.c(fg, bg, style, sp)
  local hl = {}
  if fg then
    hl.fg = fg
  end
  if bg then
    hl.bg = bg
  end
  hl = vim.tbl_extend('force', hl, M.parse_style(style))
  if sp then
    hl.sp = sp
  end
  return hl
end

---@param target string
---@return table
function M.l(target)
  return { link = target }
end

---@param groups table<string, table>
function M.apply(groups)
  for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
  end
end

return M
