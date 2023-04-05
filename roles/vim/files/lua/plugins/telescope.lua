local function ts_builtin(builtin, opts)
  return function()
    require("telescope.builtin")[builtin](opts)
  end
end

local function extension(name, fn, opts)
  return function()
    require("telescope").extensions[name][fn](opts)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-lua/plenary.nvim',
      'noice.nvim'
    },
    event = "VeryLazy",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", ts_builtin("find_files"), desc = "Find files" },
      { "<leader>fg", ts_builtin("live_grep"), desc = "Grep workspace" },
      { "<leader>fb", ts_builtin("buffers"), desc = "Find buffer" },
      { "<leader>fh", ts_builtin("help_tags"), desc = "Find help tag" },

      { "gd", ts_builtin("lsp_definitions"), desc = "Go to definition" },
      { "gU", ts_builtin("lsp_references"), desc = "List references" },
      { "gi", ts_builtin("lsp_implementations"), desc = "Go to implementations" },
      { "<space>d", ts_builtin("diagnostics"), desc = "List diagnostics" }
    },
    init = function ()
      local telescope = require('telescope')
      telescope.load_extension('ui-select')
      telescope.load_extension("noice")
    end,
  },
  {
    'aaronhallaert/advanced-git-search.nvim',
    keys = {
      { "gl", extension("git_search", "diff_commit_file"), desc = "History for file" },
      { "gL", extension("git_search", "search_log_content"), desc = "Git history" },
    },
    config = function ()
      local telescope = require('telescope')
      telescope.load_extension("advanced_git_search")
    end
  },
}
