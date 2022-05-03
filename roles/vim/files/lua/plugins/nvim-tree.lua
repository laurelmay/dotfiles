vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
}
local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

nvim_tree.setup {
  open_on_setup = true,
  open_on_setup_file = true,
  open_on_tab = true,
  update_cwd = true,
  view = { width = 32, side = "left" },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
  actions = {
    change_dir = { enable = false },
    open_file = {
      resize_window = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = true,
    custom = { 'node_modules', '.cache', '.bin' },
  },
}

map('n', '<C-n>', ':NvimTreeToggle<CR>')

vim.cmd [[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]]
