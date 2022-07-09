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

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

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
      vim.cmd [[
        highlight IndentBlanklineChar guifg=Grey30 gui=nocombine
      ]]
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

  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = {
      'ms-jpq/coq.artifacts'
    },
    run = ':COQdeps'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  use 'kylelaker/riscv.vim'
  use 'kylelaker/cisco.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
