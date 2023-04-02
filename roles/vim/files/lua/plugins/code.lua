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
    config = true,
  },
  {
    "kylechui/nvim-surround",
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    config = true,
  },
  {
    'andrewferrier/wrapping.nvim',
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
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  },
}
