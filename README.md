# Sonokai

Neovim-native Lua colorscheme based on [sainnhe/sonokai](https://github.com/sainnhe/sonokai).

Sometimes I need a high contrast color scheme, and I think monokai is one of the best solutions, it's very beautiful and vivid.

However there is one thing I can't stand -- the contrast is too high, which is totally unacceptable for me.

This color scheme is based on [Monokai Pro](https://monokai.pro/vscode), the contrast is adjusted to be a bit lower while keeping the colors vivid enough.

The `shusia`, `maia` and `espresso` variants are basically modified versions of Monokai Pro. I'm not going to port all variants of Monokai Pro because I don't like some of them. In addition, I designed some new variants inspired by other color schemes.

## Installation

```lua
{
  'alexesba/sonokai',
  lazy = false,
  priority = 1000,
}
```

## Usage

Call `require('sonokai').colorscheme()` from Lua or use `:colorscheme sonokai`. By default this uses the `default` style from your configuration.

To pick a variant directly:

- `:colorscheme sonokai`
- `:colorscheme sonokai-atlantis`
- `:colorscheme sonokai-andromeda`
- `:colorscheme sonokai-shusia`
- `:colorscheme sonokai-maia`
- `:colorscheme sonokai-espresso`

Example:

```lua
require('sonokai').setup({ enable_italic = true })
vim.cmd.colorscheme('sonokai-andromeda')
```

## Configuration

Configure the colorscheme with `require('sonokai').setup(values)`, where `values` is a table of options to override. Defaults:

```lua
require('sonokai').setup({
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
})
```

`overrides` can also be a function that returns a table of highlight groups. For example, to make the background transparent:

```lua
require('sonokai').setup({
  transparent_background = true,
  overrides = {
    Normal = { bg = 'none' },
    NormalFloat = { bg = 'none' },
  },
})
```

Sonokai also ships a theme for [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):

```lua
require('lualine').setup({
  options = {
    theme = 'sonokai',
  },
})
```

Lightline and airline themes are still available under `autoload/lightline/colorscheme/sonokai.vim` and `autoload/airline/themes/sonokai.vim`.

## Screenshots

<h2 align="center">
𝐃𝐞𝐟𝐚𝐮𝐥𝐭
</h2>

![sonokai](https://user-images.githubusercontent.com/37491630/87916859-a03dad80-caa6-11ea-9694-b34c4a980672.png)
![default](https://github.com/user-attachments/assets/a7ec8cc5-efa1-4ddb-9b46-b8dd93d3f9fa)

<h2 align="center">
𝐀𝐭𝐥𝐚𝐧𝐭𝐢𝐬
</h2>

![sonokai-atlantis](https://user-images.githubusercontent.com/37491630/87898134-ecc1c280-ca7f-11ea-8bff-df8269398b88.png)
![atlantis](https://github.com/user-attachments/assets/297b0674-6e37-4f6f-96d1-a873db1f40cf)

<h2 align="center">
𝐀𝐧𝐝𝐫𝐨𝐦𝐞𝐝𝐚
</h2>

![sonokai-andromeda](https://user-images.githubusercontent.com/37491630/87898138-ee8b8600-ca7f-11ea-90ea-681955458c68.png)
![andromeda](https://github.com/user-attachments/assets/46b171df-408a-4e18-9f37-e415d8170a07)

<h2 align="center">
𝐒𝐡𝐮𝐬𝐢𝐚
</h2>

![sonokai-shusia](https://user-images.githubusercontent.com/37491630/87898140-f0ede000-ca7f-11ea-8371-6dd5f0a205d2.png)
![shusia](https://github.com/user-attachments/assets/7ffb405e-1c17-4b45-8d70-fe8531568188)

<h2 align="center">
𝐌𝐚𝐢𝐚
</h2>

![sonokai-maia](https://user-images.githubusercontent.com/37491630/87898142-f2b7a380-ca7f-11ea-98ea-4c4e832cdbf1.png)
![maia](https://github.com/user-attachments/assets/74270438-cbb6-4509-8640-23664e11f75d)

<h2 align="center">
𝐄𝐬𝐩𝐫𝐞𝐬𝐬𝐨
</h2>

![sonokai-espresso](https://user-images.githubusercontent.com/37491630/120320919-49834000-c315-11eb-872c-230f78cf99a1.png)
![espresso](https://github.com/user-attachments/assets/4c5071db-36a5-463a-91a4-78793b5e49ca)

## Features

- High contrast but within acceptable range.
- Vivid colors.
- Highly customizable.
- Rich support for common file types and plugins.
- Tree-sitter support.
- Semantic highlighting support.
- [Italic support](https://aka.sainnhe.dev/fonts) 🎉

## Documentation

See [`:help sonokai.txt`](doc/sonokai.txt) for full Neovim Lua usage, configuration options, and FAQ.

## Related Projects

See this [wiki page](https://github.com/sainnhe/sonokai/wiki/Related-Projects).

## Contributing

See this [post](https://www.sainnhe.dev/post/contributing-guide/).

## More Color Schemes

- [Gruvbox Material](https://github.com/sainnhe/gruvbox-material)
- [Everforest](https://github.com/sainnhe/everforest)
- [Edge](https://github.com/sainnhe/edge)

## Inspirations

- [Monokai Pro](https://monokai.pro/vscode)
- [Atom One](https://github.com/atom/atom/tree/master/packages/one-dark-syntax)
- [Material](https://github.com/equinusocio/material-theme)
- [Nord](https://www.nordtheme.com)

## Maintainers

| [![Sainnhe Park](https://avatars1.githubusercontent.com/u/37491630?s=70&u=14e72916dcf467f393c532536387ec72a23747ec&v=4)](https://github.com/sainnhe) | [![Antoine Cotten](https://avatars.githubusercontent.com/u/3299086?v=4&s=70)](https://github.com/antoineco) |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| [Sainnhe Park](https://github.com/sainnhe)                                                                                                           | [Antoine Cotten](https://github.com/antoineco)                                                              |

## License

[MIT](./LICENSE) © sainnhe
