return {
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = 'markdown',
  },
  {
    'lervag/vimtex',
    ft = 'tex'
  },
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
  },
  {
    'vuki656/package-info.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
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
  },
  {
    "kylechui/nvim-surround",
    event = 'VeryLazy',
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    event = 'VeryLazy',
    config = true,
  },
  {
    'andrewferrier/wrapping.nvim',
    cmd = {
      'HardWrapMode',
      'SoftWrapMode',
      'ToggleWrapMode',
      'WrappingOpenLog',
    },
    keys = { '[ow', ']ow', 'yow' },
    config = true,
  },
  {
    'danymat/neogen',
    dependencies = {
      'L3MON4D3/LuaSnip',
      "nvim-treesitter/nvim-treesitter"
    },
    keys = {
      { "<leader>nf", function() require('neogen').generate() end, desc = "Generate annotation" }
    },
    opts = {
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            annotation_convention = "reST"
          }
        }
      }
    }
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    keys = { "gc", "gb", "gcc", "gbc", "gcO", "gco", "gcA" },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  },
}
