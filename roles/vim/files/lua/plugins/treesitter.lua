require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = {
    -- phpdoc TS parser compilation is broken on M1 Macs and other ARM64
    'phpdoc'
  },
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
    extended_mode = true,
  },
}

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
