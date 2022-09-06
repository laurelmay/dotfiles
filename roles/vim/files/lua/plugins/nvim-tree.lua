local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

nvim_tree.setup {
  open_on_setup = true,
  open_on_tab = true,
  sync_root_with_cwd = true,
  disable_netrw = true,
  view = { width = 32 },
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
    custom = { 'node_modules', '^\\.git$' },
  },
}

_G.map('n', '<C-n>', ':NvimTreeToggle<CR>')

