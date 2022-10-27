_G.config = {}

require('packer_init')
require('options')
require('keymap')

-- Ideally, most of these would actually get called from a `config` in `packer_init`
-- rather than needing to be called directly from init.lua
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.nvim-cmp')
require('plugins.lsp.lspconfig')
require('plugins.lsp.null-ls')
require('plugins.gitsigns')
