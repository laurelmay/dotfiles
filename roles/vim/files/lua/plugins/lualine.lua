require'lualine'.setup {
  tabline = {
    lualine_a = {'branch'},
    lualine_b = {'buffers'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  },
  sections = {
    lualine_c = {'lsp_progress'}
  },
  extensions = {'neo-tree'},
}
