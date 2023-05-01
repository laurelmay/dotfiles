return {
  -- Replace mini.pairs with nvim-autopairs
  { "mini.pairs", enabled = false },
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    config = true,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = 'markdown',
  },
}
