local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

local packerGroup = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "packer_init.lua" },
  command = "source <afile> | PackerSync",
  group = packerGroup,
})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    after = "github-nvim-theme",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require'lualine'.setup {
        tabline = {
            lualine_a = {'branch'},
            lualine_b = {'buffers'},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {'tabs'}
        },
        extensions = {'nvim-tree'},
      }
    end
  }

  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }
  use {
    'projekt0n/github-nvim-theme',
    config = function()
      require'github-theme'.setup {
        theme_style = "dimmed",
        keyword_style = "NONE"
      }
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_char = '¦'
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_use_treesitter_scope = true
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.cmd.highlight "IndentBlanklineChar guifg=Grey30 gui=nocombine"
      require'indent_blankline'.setup{
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow'
  use {
    "kylechui/nvim-surround",
    config = function()
      require'nvim-surround'.setup{}
    end
  }

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim",
    "neovim/nvim-lspconfig",
  }

  use {
    'L3MON4D3/LuaSnip',
    { tag = 'v1.*' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  }

  -- Autocompletion setup
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'onsails/lspkind.nvim',
    'saadparwaiz1/cmp_luasnip',
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    }
  }
  use "jayp0521/mason-null-ls.nvim"

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }
  use 'kylelaker/riscv.vim'
  use 'kylelaker/cisco.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
