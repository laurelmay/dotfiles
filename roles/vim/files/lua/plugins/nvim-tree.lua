local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

nvim_tree.setup {
  open_on_setup = true,
  open_on_setup_file = true,
  open_on_tab = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  disable_netrw = true,
  view = { width = 32, side = "left" },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_opened_files = "icon",
    highlight_git = true,
   },
  actions = {
    change_dir = { enable = false },
    open_file = {
      resize_window = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
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
