return {
  -- Replace mini.pairs with nvim-autopairs
  { "mini.pairs", enabled = false },
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
  },

  {
    'monkoose/matchparen.nvim',
    config = true,
    event = 'BufReadPost'
  }
}
