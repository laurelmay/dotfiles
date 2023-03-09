local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

telescope.setup {}
telescope.load_extension('ui-select')
telescope.load_extension("noice")
telescope.load_extension("advanced_git_search")

local builtins = require 'telescope.builtin'
_G.map('n', '<leader>ff', builtins.find_files, { desc = "Find files" })
_G.map('n', '<leader>fg', builtins.live_grep, { desc = "Grep workspace" })
_G.map('n', '<leader>fb', builtins.buffers, { desc = "Find buffer" })
_G.map('n', '<leader>fh', builtins.help_tags, { desc = "Find help tag" })
-- LSP-related keymapings
_G.map('n', 'gd', builtins.lsp_definitions, { desc = "Go to definition" })
_G.map('n', 'gU', builtins.lsp_references, { desc = "Go to references" })
_G.map('n', 'gi', builtins.lsp_implementations, { desc = "Go to implementations"})
_G.map('n', '<space>d', builtins.diagnostics, { desc = "List diagnostics" })
-- Git-related queries
local git_search = telescope.extensions.advanced_git_search
_G.map('n', 'gl', git_search.diff_commit_file, { desc = "History for file" })
_G.map('n', 'gL', git_search.search_log_content, { desc = "Git history" })
