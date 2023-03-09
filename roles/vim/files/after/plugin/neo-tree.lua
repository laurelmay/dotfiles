vim.g.neo_tree_remove_legacy_commands = 1

require "neo-tree".setup {
  close_if_last_window = true,
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      always_show = { ".github", ".projenrc.js", ".projenrc.ts" },
      never_show = { ".git", 'node_modules' },
    },
  },
}
_G.map('n', '<C-n>', '<cmd>Neotree toggle<CR>', { silent = true, desc = "Toggle file browser" })

-- Show the file explorer by default, based on
-- https://github.com/AstroNvim/AstroNvim/issues/648
vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Open neo-tree on enter",
  group = "neotree_autoopen",
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd "Neotree show"
      vim.g.neotree_opened = true
    end
  end,
})

