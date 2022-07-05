local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

telescope.setup {}
telescope.load_extension('ui-select')

local builtinFn = require 'telescope.builtin'
_G.map('n', '<leader>ff', builtinFn.find_files)
_G.map('n', '<leader>fg', builtinFn.live_grep)
_G.map('n', '<leader>fb', builtinFn.buffers)
_G.map('n', '<leader>fh', builtinFn.help_tags)
