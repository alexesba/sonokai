local colors = require('sonokai.colors')
local config = require('sonokai.config')
local util = require('sonokai.util')

local M = {}

local function p(name)
  return colors[name]
end

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

function M.set_lsp_kind_colors()
  vim.g.sonokai_lsp_kind_color = {
    { 'Array', 'Yellow' },
    { 'Boolean', 'Yellow' },
    { 'Class', 'Blue' },
    { 'Color', 'Yellow' },
    { 'Constant', 'Orange' },
    { 'Constructor', 'Green' },
    { 'Default', 'Yellow' },
    { 'Enum', 'Blue' },
    { 'EnumMember', 'Purple' },
    { 'Event', 'Yellow' },
    { 'Field', 'Green' },
    { 'File', 'Green' },
    { 'Folder', 'Yellow' },
    { 'Function', 'Green' },
    { 'Interface', 'Blue' },
    { 'Key', 'Red' },
    { 'Keyword', 'Red' },
    { 'Method', 'Green' },
    { 'Module', 'Blue' },
    { 'Namespace', 'Red' },
    { 'Null', 'Yellow' },
    { 'Number', 'Yellow' },
    { 'Object', 'Yellow' },
    { 'Operator', 'Red' },
    { 'Package', 'Red' },
    { 'Property', 'Orange' },
    { 'Reference', 'Yellow' },
    { 'Snippet', 'Yellow' },
    { 'String', 'Yellow' },
    { 'Struct', 'Blue' },
    { 'Text', 'Fg' },
    { 'TypeParameter', 'Blue' },
    { 'Unit', 'Purple' },
    { 'Value', 'Purple' },
    { 'Variable', 'Orange' },
  }
end

local function set_ui(groups)
  local transparent = transparent_background()
  local none = p('none')

  if transparent ~= 0 then
    groups.Normal = util.c(p('fg'), none)
    groups.NormalNC = util.c(p('fg'), none)
    groups.Terminal = util.c(p('fg'), none)
    groups.EndOfBuffer = config.show_eob and util.c(p('bg4'), none) or util.c(p('bg0'), none)
    groups.Folded = util.c(p('grey'), none)
    groups.ToolbarLine = util.c(p('fg'), none)
    groups.FoldColumn = util.c(p('grey_dim'), none)
  else
    groups.Normal = util.c(p('fg'), p('bg0'))
    groups.NormalNC = config.dim_inactive_windows and util.c(p('fg'), p('bg_dim')) or util.c(p('fg'), p('bg0'))
    groups.Terminal = util.c(p('fg'), p('bg0'))
    groups.EndOfBuffer = config.show_eob and util.c(p('bg4'), none) or util.c(p('bg0'), none)
    groups.Folded = util.c(p('grey'), p('bg1'))
    groups.ToolbarLine = util.c(p('fg'), p('bg2'))
    groups.FoldColumn = util.c(p('grey_dim'), none)
  end

  groups.SignColumn = util.c(p('fg'), none)
  groups.IncSearch = util.c(p('bg0'), p('filled_red'))
  groups.Search = util.c(p('bg0'), p('filled_green'))
  groups.CurSearch = util.l('IncSearch')
  groups.ColorColumn = util.c(none, p('bg1'))
  groups.Conceal = util.c(p('grey_dim'), none)

  if config.cursor == 'auto' then
    groups.Cursor = util.c(none, none, 'reverse')
  elseif config.cursor ~= '' and colors[config.cursor] then
    groups.Cursor = util.c(p('bg0'), p(config.cursor))
  end

  groups.vCursor = util.l('Cursor')
  groups.iCursor = util.l('Cursor')
  groups.lCursor = util.l('Cursor')
  groups.CursorIM = util.l('Cursor')

  if vim.o.diff then
    groups.CursorLine = util.c(none, none, 'underline')
    groups.CursorColumn = util.c(none, none, 'bold')
    groups.CursorLineNr = util.c(p('fg'), none, 'underline')
  else
    groups.CursorLine = util.c(none, p('bg1'))
    groups.CursorColumn = util.c(none, p('bg1'))
    groups.CursorLineNr = util.c(p('fg'), none)
  end

  groups.LineNr = util.c(p('grey_dim'), none)
  groups.DiffAdd = util.c(none, p('bg_green'))
  groups.DiffChange = util.c(none, p('bg_blue'))
  groups.DiffDelete = util.c(none, p('bg_red'))
  groups.DiffText = util.c(p('bg0'), p('blue'))
  groups.Directory = util.c(p('green'), none)
  groups.ErrorMsg = util.c(p('red'), none, 'bold,underline')
  groups.WarningMsg = util.c(p('yellow'), none, 'bold')
  groups.ModeMsg = util.c(p('fg'), none, 'bold')
  groups.MoreMsg = util.c(p('blue'), none, 'bold')
  groups.MatchParen = util.c(none, p('bg4'))
  groups.NonText = util.c(p('bg4'), none)
  groups.Whitespace = util.c(p('bg4'), none)
  groups.SpecialKey = util.c(p('purple'), none)
  groups.Pmenu = util.c(p('fg'), p('bg2'))
  groups.PmenuSbar = util.c(none, p('bg2'))

  local menu_bg = {
    blue = p('filled_blue'),
    green = p('filled_green'),
    red = p('filled_red'),
  }
  groups.PmenuSel = util.c(p('bg0'), menu_bg[config.menu_selection_background] or p('filled_blue'))
  groups.PmenuKind = util.c(p('green'), p('bg2'))
  groups.PmenuExtra = util.c(p('grey'), p('bg2'))
  groups.WildMenu = util.l('PmenuSel')
  groups.PmenuThumb = util.c(none, p('grey'))

  if config.float_style == 'dim' then
    groups.NormalFloat = util.c(p('fg'), p('bg_dim'))
    groups.FloatBorder = util.c(p('grey'), p('bg_dim'))
    groups.FloatTitle = util.c(p('red'), p('bg0'), 'bold')
  elseif config.float_style == 'blend' then
    if transparent ~= 0 then
      groups.NormalFloat = util.l('Normal')
      groups.FloatBorder = util.l('Grey')
      groups.FloatTitle = util.c(p('red'), none, 'bold')
    else
      groups.NormalFloat = util.c(p('fg'), p('bg0'))
      groups.FloatBorder = util.c(p('grey'), p('bg0'))
      groups.FloatTitle = util.c(p('red'), p('bg1'), 'bold')
    end
  else
    groups.NormalFloat = util.c(p('fg'), p('bg2'))
    groups.FloatBorder = util.c(p('grey'), p('bg2'))
    groups.FloatTitle = util.c(p('red'), p('bg4'), 'bold')
  end

  groups.Question = util.c(p('yellow'), none)

  if config.spell_foreground == 'none' then
    groups.SpellBad = util.c(none, none, 'undercurl', p('red'))
    groups.SpellCap = util.c(none, none, 'undercurl', p('yellow'))
    groups.SpellLocal = util.c(none, none, 'undercurl', p('blue'))
    groups.SpellRare = util.c(none, none, 'undercurl', p('purple'))
  else
    groups.SpellBad = util.c(p('red'), none, 'undercurl', p('red'))
    groups.SpellCap = util.c(p('yellow'), none, 'undercurl', p('yellow'))
    groups.SpellLocal = util.c(p('blue'), none, 'undercurl', p('blue'))
    groups.SpellRare = util.c(p('purple'), none, 'undercurl', p('purple'))
  end

  if transparent == 2 then
    groups.StatusLine = util.c(p('fg'), none)
    groups.StatusLineTerm = util.c(p('fg'), none)
    groups.StatusLineNC = util.c(p('grey'), none)
    groups.StatusLineTermNC = util.c(p('grey'), none)
    groups.TabLine = util.c(p('fg'), p('bg4'))
    groups.TabLineFill = util.c(p('grey'), none)
    groups.TabLineSel = util.c(p('bg0'), p('filled_red'))
    groups.WinBar = util.c(p('fg'), none, 'bold')
    groups.WinBarNC = util.c(p('grey'), none)
  else
    groups.StatusLine = util.c(p('fg'), p('bg3'))
    groups.StatusLineTerm = util.c(p('fg'), p('bg3'))
    groups.StatusLineNC = util.c(p('grey'), p('bg1'))
    groups.StatusLineTermNC = util.c(p('grey'), p('bg1'))
    groups.TabLine = util.c(p('fg'), p('bg4'))
    groups.TabLineFill = util.c(p('grey'), p('bg1'))
    groups.TabLineSel = util.c(p('bg0'), p('filled_red'))
    groups.WinBar = util.c(p('fg'), p('bg3'), 'bold')
    groups.WinBarNC = util.c(p('grey'), p('bg1'))
  end

  groups.VertSplit = config.dim_inactive_windows and util.c(p('bg4'), p('bg_dim')) or util.c(p('black'), none)
  groups.WinSeparator = util.l('VertSplit')
  groups.Visual = util.c(none, p('bg4'))
  groups.VisualNOS = util.c(none, p('bg4'), 'underline')
  groups.QuickFixLine = util.c(p('blue'), none, 'bold')
  groups.Debug = util.c(p('yellow'), none)
  groups.debugPC = util.c(p('bg0'), p('green'))
  groups.debugBreakpoint = util.c(p('bg0'), p('red'))
  groups.ToolbarButton = util.c(p('bg0'), p('filled_blue'))
  groups.Substitute = util.c(p('bg0'), p('yellow'))

  if config.diagnostic_text_highlight then
    groups.DiagnosticError = util.c(p('red'), p('bg_red'))
    groups.DiagnosticUnderlineError = util.c(none, p('bg_red'), 'undercurl', p('red'))
    groups.DiagnosticWarn = util.c(p('yellow'), p('bg_yellow'))
    groups.DiagnosticUnderlineWarn = util.c(none, p('bg_yellow'), 'undercurl', p('yellow'))
    groups.DiagnosticInfo = util.c(p('blue'), p('bg_blue'))
    groups.DiagnosticUnderlineInfo = util.c(none, p('bg_blue'), 'undercurl', p('blue'))
    groups.DiagnosticHint = util.c(p('purple'), p('bg_purple'))
    groups.DiagnosticUnderlineHint = util.c(none, p('bg_purple'), 'undercurl', p('purple'))
    groups.DiagnosticOk = util.c(p('green'), p('bg_green'))
    groups.DiagnosticUnderlineOk = util.c(none, p('bg_green'), 'undercurl', p('green'))
  else
    groups.DiagnosticError = util.c(p('red'), none)
    groups.DiagnosticUnderlineError = util.c(none, none, 'undercurl', p('red'))
    groups.DiagnosticWarn = util.c(p('yellow'), none)
    groups.DiagnosticUnderlineWarn = util.c(none, none, 'undercurl', p('yellow'))
    groups.DiagnosticInfo = util.c(p('blue'), none)
    groups.DiagnosticUnderlineInfo = util.c(none, none, 'undercurl', p('blue'))
    groups.DiagnosticHint = util.c(p('purple'), none)
    groups.DiagnosticUnderlineHint = util.c(none, none, 'undercurl', p('purple'))
    groups.DiagnosticOk = util.c(p('green'), none)
    groups.DiagnosticUnderlineOk = util.c(none, none, 'undercurl', p('green'))
  end

  local diagnostic_links = {
    DiagnosticFloatingError = 'ErrorFloat',
    DiagnosticFloatingWarn = 'WarningFloat',
    DiagnosticFloatingInfo = 'InfoFloat',
    DiagnosticFloatingHint = 'HintFloat',
    DiagnosticFloatingOk = 'OkFloat',
    DiagnosticVirtualTextError = 'VirtualTextError',
    DiagnosticVirtualTextWarn = 'VirtualTextWarning',
    DiagnosticVirtualTextInfo = 'VirtualTextInfo',
    DiagnosticVirtualTextHint = 'VirtualTextHint',
    DiagnosticVirtualTextOk = 'VirtualTextOk',
    DiagnosticSignError = 'RedSign',
    DiagnosticSignWarn = 'YellowSign',
    DiagnosticSignInfo = 'BlueSign',
    DiagnosticSignHint = 'PurpleSign',
    DiagnosticSignOk = 'GreenSign',
    LspDiagnosticsFloatingError = 'DiagnosticFloatingError',
    LspDiagnosticsFloatingWarning = 'DiagnosticFloatingWarn',
    LspDiagnosticsFloatingInformation = 'DiagnosticFloatingInfo',
    LspDiagnosticsFloatingHint = 'DiagnosticFloatingHint',
    LspDiagnosticsDefaultError = 'DiagnosticError',
    LspDiagnosticsDefaultWarning = 'DiagnosticWarn',
    LspDiagnosticsDefaultInformation = 'DiagnosticInfo',
    LspDiagnosticsDefaultHint = 'DiagnosticHint',
    LspDiagnosticsVirtualTextError = 'DiagnosticVirtualTextError',
    LspDiagnosticsVirtualTextWarning = 'DiagnosticVirtualTextWarn',
    LspDiagnosticsVirtualTextInformation = 'DiagnosticVirtualTextInfo',
    LspDiagnosticsVirtualTextHint = 'DiagnosticVirtualTextHint',
    LspDiagnosticsUnderlineError = 'DiagnosticUnderlineError',
    LspDiagnosticsUnderlineWarning = 'DiagnosticUnderlineWarn',
    LspDiagnosticsUnderlineInformation = 'DiagnosticUnderlineInfo',
    LspDiagnosticsUnderlineHint = 'DiagnosticUnderlineHint',
    LspDiagnosticsSignError = 'DiagnosticSignError',
    LspDiagnosticsSignWarning = 'DiagnosticSignWarn',
    LspDiagnosticsSignInformation = 'DiagnosticSignInfo',
    LspDiagnosticsSignHint = 'DiagnosticSignHint',
    LspReferenceText = 'CurrentWord',
    LspReferenceRead = 'CurrentWord',
    LspReferenceWrite = 'CurrentWord',
    LspInlayHint = 'InlayHints',
    LspCodeLens = 'VirtualTextInfo',
    LspCodeLensSeparator = 'VirtualTextHint',
    LspSignatureActiveParameter = 'Search',
    TermCursor = 'Cursor',
    healthError = 'Red',
    healthSuccess = 'Green',
    healthWarning = 'Yellow',
  }

  for group, target in pairs(diagnostic_links) do
    groups[group] = util.l(target)
  end
end

local function set_syntax(groups)
  local italic = config.enable_italic and 'italic' or nil

  groups.Type = util.c(p('blue'), p('none'), italic)
  groups.Structure = util.c(p('blue'), p('none'), italic)
  groups.StorageClass = util.c(p('blue'), p('none'), italic)
  groups.Identifier = util.c(p('orange'), p('none'), italic)
  groups.Constant = util.c(p('orange'), p('none'), italic)
  groups.PreProc = util.c(p('red'), p('none'))
  groups.PreCondit = util.c(p('red'), p('none'))
  groups.Include = util.c(p('red'), p('none'))
  groups.Keyword = util.c(p('red'), p('none'))
  groups.Define = util.c(p('red'), p('none'))
  groups.Typedef = util.c(p('red'), p('none'))
  groups.Exception = util.c(p('red'), p('none'))
  groups.Conditional = util.c(p('red'), p('none'))
  groups.Repeat = util.c(p('red'), p('none'))
  groups.Statement = util.c(p('red'), p('none'))
  groups.Macro = util.c(p('purple'), p('none'))
  groups.Error = util.c(p('red'), p('none'))
  groups.Label = util.c(p('purple'), p('none'))
  groups.Special = util.c(p('purple'), p('none'))
  groups.SpecialChar = util.c(p('purple'), p('none'))
  groups.Boolean = util.c(p('purple'), p('none'))
  groups.String = util.c(p('yellow'), p('none'))
  groups.Character = util.c(p('yellow'), p('none'))
  groups.Number = util.c(p('purple'), p('none'))
  groups.Float = util.c(p('purple'), p('none'))
  groups.Function = util.c(p('green'), p('none'))
  groups.Operator = util.c(p('red'), p('none'))
  groups.Title = util.c(p('red'), p('none'), 'bold')
  groups.Tag = util.c(p('orange'), p('none'))
  groups.Delimiter = util.c(p('fg'), p('none'))
  groups.Todo = util.c(p('bg0'), p('blue'), 'bold')

  local comment_style = config.disable_italic_comment and nil or 'italic'
  groups.Comment = util.c(p('grey'), p('none'), comment_style)
  groups.SpecialComment = util.c(p('grey'), p('none'), comment_style)
  groups.Ignore = util.c(p('grey'), p('none'))
  groups.Underlined = util.c(p('none'), p('none'), 'underline')
end

local function set_predefined(groups)
  groups.Fg = util.c(p('fg'), p('none'))
  groups.Grey = util.c(p('grey'), p('none'))
  groups.Red = util.c(p('red'), p('none'))
  groups.Orange = util.c(p('orange'), p('none'))
  groups.Yellow = util.c(p('yellow'), p('none'))
  groups.Green = util.c(p('green'), p('none'))
  groups.Blue = util.c(p('blue'), p('none'))
  groups.Purple = util.c(p('purple'), p('none'))

  local italic = config.enable_italic and 'italic' or nil
  groups.RedItalic = util.c(p('red'), p('none'), italic)
  groups.OrangeItalic = util.c(p('orange'), p('none'), italic)
  groups.YellowItalic = util.c(p('yellow'), p('none'), italic)
  groups.GreenItalic = util.c(p('green'), p('none'), italic)
  groups.BlueItalic = util.c(p('blue'), p('none'), italic)
  groups.PurpleItalic = util.c(p('purple'), p('none'), italic)

  groups.RedSign = util.c(p('red'), p('none'))
  groups.OrangeSign = util.c(p('orange'), p('none'))
  groups.YellowSign = util.c(p('yellow'), p('none'))
  groups.GreenSign = util.c(p('green'), p('none'))
  groups.BlueSign = util.c(p('blue'), p('none'))
  groups.PurpleSign = util.c(p('purple'), p('none'))
  groups.Added = util.l('Green')
  groups.Removed = util.l('Red')
  groups.Changed = util.l('Blue')

  if config.diagnostic_text_highlight then
    groups.ErrorText = util.c(p('none'), p('bg_red'), 'undercurl', p('red'))
    groups.WarningText = util.c(p('none'), p('bg_yellow'), 'undercurl', p('yellow'))
    groups.InfoText = util.c(p('none'), p('bg_blue'), 'undercurl', p('blue'))
    groups.HintText = util.c(p('none'), p('bg_purple'), 'undercurl', p('purple'))
  else
    groups.ErrorText = util.c(p('none'), p('none'), 'undercurl', p('red'))
    groups.WarningText = util.c(p('none'), p('none'), 'undercurl', p('yellow'))
    groups.InfoText = util.c(p('none'), p('none'), 'undercurl', p('blue'))
    groups.HintText = util.c(p('none'), p('none'), 'undercurl', p('purple'))
  end

  if config.diagnostic_line_highlight then
    groups.ErrorLine = util.c(p('none'), p('bg_red'))
    groups.WarningLine = util.c(p('none'), p('bg_yellow'))
    groups.InfoLine = util.c(p('none'), p('bg_blue'))
    groups.HintLine = util.c(p('none'), p('bg_purple'))
  end

  if config.diagnostic_virtual_text == 'grey' then
    groups.VirtualTextWarning = util.l('Grey')
    groups.VirtualTextError = util.l('Grey')
    groups.VirtualTextInfo = util.l('Grey')
    groups.VirtualTextHint = util.l('Grey')
    groups.VirtualTextOk = util.l('Grey')
  elseif config.diagnostic_virtual_text == 'colored' then
    groups.VirtualTextWarning = util.l('Yellow')
    groups.VirtualTextError = util.l('Red')
    groups.VirtualTextInfo = util.l('Blue')
    groups.VirtualTextHint = util.l('Purple')
    groups.VirtualTextOk = util.l('Green')
  else
    groups.VirtualTextWarning = util.c(p('yellow'), p('bg_yellow'))
    groups.VirtualTextError = util.c(p('red'), p('bg_red'))
    groups.VirtualTextInfo = util.c(p('blue'), p('bg_blue'))
    groups.VirtualTextHint = util.c(p('purple'), p('bg_purple'))
    groups.VirtualTextOk = util.c(p('green'), p('bg_green'))
  end

  groups.ErrorFloat = util.c(p('red'), p('none'))
  groups.WarningFloat = util.c(p('yellow'), p('none'))
  groups.InfoFloat = util.c(p('blue'), p('none'))
  groups.HintFloat = util.c(p('purple'), p('none'))
  groups.OkFloat = util.c(p('green'), p('none'))

  local current_word = config.current_word
  if current_word == nil then
    current_word = transparent_background() == 0 and 'grey background' or 'bold'
  end

  if vim.o.diff then
    groups.CurrentWord = util.c(p('bg0'), p('green'))
  elseif current_word == 'grey background' then
    groups.CurrentWord = util.c(p('none'), p('bg2'))
  elseif current_word == 'high contrast background' then
    groups.CurrentWord = util.c(p('none'), p('bg4'))
  else
    groups.CurrentWord = util.c(p('none'), p('none'), current_word)
  end

  if config.inlay_hints_background == 'none' then
    groups.InlayHints = util.l('LineNr')
  else
    groups.InlayHints = util.c(p('grey'), p('bg_dim'))
  end
end

function M.set_groups()
  local groups = {}
  M.set_lsp_kind_colors()
  set_ui(groups)
  set_syntax(groups)
  set_predefined(groups)
  require('sonokai.highlights.plugins').set_groups(groups)
  util.apply(groups)
end

return M
