return {
  {
    'vuki656/package-info.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim'
    },
    ft = 'json',
    keys = {
      { "<leader>ns", function() require('package-info').show() end, desc = "Show versions" },
      { "<leader>nd", function() require('package-info').delete() end, desc = "Delete package" },
      { "<leader>nt", function() require('package-info').toggle() end, desc = "Toggle versions" },
      { "<leader>np", function() require('package-info').change_version() end, desc = "Install different version" },
      { "<leader>nu", function() require('package-info').update() end, desc = "Upgrade dependency" },
      { "<leader>ni", function() require('package-info').install() end, desc = "Instal dependency" },
    },
    config = true,
  }
}
