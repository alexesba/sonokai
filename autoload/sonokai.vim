" Neovim compatibility shims for lightline and airline themes.

function! sonokai#get_configuration()
  return v:lua.require('sonokai.compat').get_configuration()
endfunction

function! sonokai#get_palette(style, colors_override)
  return v:lua.require('sonokai.compat').get_palette(a:style, a:colors_override)
endfunction
