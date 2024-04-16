local Plugin = require('lazyvim.util.plugin')

local config = {};

if Plugin.extra_idx("ui.edgy") then
  local edgy = {
    'edgy.nvim',
    opts = {
      exit_when_last = true,
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = function()
            local leader = vim.g.mapleader
            vim.api.nvim_input('<esc>' .. leader .. 'e')
          end,
          size = { height = 0.5 },
        },
        { title = "Neotest Summary", ft = "neotest-summary" },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        "neo-tree",
      },
    }
  }
  table.insert(config, edgy)
end

return config
