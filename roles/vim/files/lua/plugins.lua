local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd.packadd("packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "source <afile> | PackerSync",
  group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
})

require('packer').init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'projekt0n/github-nvim-theme',
    config = function()
      require 'github-theme'.setup {
        theme_style = "dimmed",
        keyword_style = "NONE"
      }
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    after = "github-nvim-theme",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use 'WhoIsSethDaniel/lualine-lsp-progress.nvim'

  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    "kylechui/nvim-surround",
    config = function() require 'nvim-surround'.setup {} end
  }
  use {
    "m4xshen/autoclose.nvim",
    config = function() require 'autoclose'.setup {} end
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function() require "nvim-ts-autotag".setup {} end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
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
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "jayp0521/mason-null-ls.nvim",
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'p00f/nvim-ts-rainbow',
  }

  use {
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' }
  }

  use {
    'folke/noice.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  }

  use 'WhoIsSethDaniel/mason-tool-installer.nvim'

  use {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
  }
  use 'simrat39/rust-tools.nvim'

  use 'kylelaker/riscv.vim'
  use 'kylelaker/cisco.vim'

  use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn["mkdp#util#install"]() end
  }
  use 'lervag/vimtex'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
