require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false
  },
  context = {
    enable = true,
    patterns = {
      default = {
        'class',
        'function',
        'if',
        'for',
        'switch',
        'case',
      }
    }
  },
  rainbow = {
    enable = true,
  },
}

vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
