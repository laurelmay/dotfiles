-- Derived from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/packer_init.lua
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
  use 'Yggdroot/indentLine'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'ishan9299/nvim-solarized-lua'
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
