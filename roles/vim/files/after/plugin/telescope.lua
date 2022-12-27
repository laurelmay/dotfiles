local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

telescope.setup {}
telescope.load_extension('ui-select')
telescope.load_extension("noice")

local builtins = require 'telescope.builtin'
_G.map('n', '<leader>ff', builtins.find_files)
_G.map('n', '<leader>fg', builtins.live_grep)
_G.map('n', '<leader>fb', builtins.buffers)
_G.map('n', '<leader>fh', builtins.help_tags)
-- LSP-related keymapings
_G.map('n', 'gd', builtins.lsp_definitions)
_G.map('n', 'gU', builtins.lsp_references)
_G.map('n', 'gi', builtins.lsp_implementations)
_G.map('n', '<space>d', builtins.diagnostics)
