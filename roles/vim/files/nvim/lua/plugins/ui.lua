return {
  {
    "neo-tree.nvim",
    lazy = false,
    keys = {
      { "<C-n>", "<cmd>Neotree toggle<cr>", silent = true, desc = "Toggle file browser" },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = true,
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          always_show = { ".github", ".projenrc.js", ".projenrc.ts" },
          never_show = { ".git", "node_modules" },
        },
      },
    },
  },
}
