local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "packer_init.lua" },
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

  use 'WhoIsSethDaniel/lualine-lsp-progress.nvim'
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
    'nvim-lualine/lualine.nvim',
    after = "github-nvim-theme",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugins.lualine') end
  }

  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      { 'kyazdani42/nvim-web-devicons', opt = false },
    },
    config = function() require 'octo'.setup() end,
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require'indent_blankline'.setup {
        char = '¦',
        use_treesitter = true,
        use_treesitter_scope = true,
        show_trailing_blankline_indent = true,
        show_current_context = true,
        show_current_context_start = true,
      }
    end
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
    "windwp/nvim-autopairs",
    config = function() require "nvim-autopairs".setup {} end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
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
    config = function ()
      vim.g.neo_tree_remove_legacy_commands = 1
      require "neo-tree".setup {
        close_if_last_window = true,
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            always_show = { ".github" },
            never_show = { ".git", 'node_modules' },
          },
        },
        event_handlers = {
          {
            event = "vim_buffer_enter",
            handler = function()
              if vim.bo.filetype == "neo-tree" then
                vim.cmd("setlocal nonumber")
              end
            end
          },
        },
      }
      _G.map('n', '<C-n>', ':Neotree toggle<CR>')

      -- Show the file explorer by default, based on
      -- https://github.com/AstroNvim/AstroNvim/issues/648
      vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        desc = "Open neo-tree on enter",
        group = "neotree_autoopen",
        callback = function()
          if not vim.g.neotree_opened then
            vim.cmd "Neotree show"
            vim.g.neotree_opened = true
          end
        end,
      })
    end,
  }

  use {
    'rcarriga/nvim-notify',
    config = function ()
      vim.notify = require 'notify'
      vim.notify.setup {
        stages = "fade",
        level = "DEBUG",
      }
    end
  }

  use 'kylelaker/riscv.vim'
  use 'kylelaker/cisco.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)


