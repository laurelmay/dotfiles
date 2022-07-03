require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
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
  }
}
