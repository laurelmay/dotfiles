local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'WhoIsSethDaniel/lualine-lsp-progress.nvim',
    },
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  'lewis6991/gitsigns.nvim',
  'lukas-reineke/indent-blankline.nvim',
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
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- LSP configs
      'b0o/schemastore.nvim',
    }
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jayp0521/mason-null-ls.nvim",
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
      'HiPhish/nvim-ts-rainbow2',
    },
    build = ':TSUpdate'
  },
  {
    'danymat/neogen',
    dependencies = {
      'L3MON4D3/LuaSnip',
      "nvim-treesitter/nvim-treesitter"
    },
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' }
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = {
      auto_open = true,
      auto_close = true,
      use_diagnostic_signs = true,
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-lua/plenary.nvim',
      'aaronhallaert/advanced-git-search.nvim',
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    }
  },
  'simrat39/rust-tools.nvim',
  {
    'vuki656/package-info.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = true,
  },
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
    'kylelaker/riscv.vim',
    dev = true,
  },
  {
    'kylelaker/cisco.vim',
    dev = true,
  },
  {
    'kylelaker/y86.vim',
    dev = true,
  },
  {
    'andweeb/presence.nvim',
  },
}

require("lazy").setup(plugins,
{
  dev = {
    path = "~/Documents/vim-plugins",
  },
  install = {
    colorscheme = { "catppuccin" },
  },
}
)
