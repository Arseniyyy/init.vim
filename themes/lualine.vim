lua << END
require('lualine').setup{
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = "⮀", right = "⮂"},
    section_separators = { left = "⮀", right = "⮂"},
  },
  sections = {
    lualine_a = {
      {'filename', path = 1},
    },
    lualine_b = {'diff', 'diagnostics'},
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}
END
