local Plugin = require('lazyvim.util.plugin')

local config = {};

if Plugin.extra_idx("ui.edgy") then
  local edgy = {
    'edgy.nvim',
    opts = {
      exit_when_last = true
    }
  }
  table.insert(config, edgy)
end

return config
