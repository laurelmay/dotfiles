require'lualine'.setup {
  sections = {
    lualine_c = {'lsp_progress'}
  },
  extensions = {
    'neo-tree',
    'nvim-dap-ui',
  },
}

require 'bufferline'.setup {
  options = {
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
      },
    },
  }
}

_G.map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
_G.map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
