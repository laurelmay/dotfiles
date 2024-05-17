return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      context = {
        patterns = {
          default = {
            "class",
            "function",
            "if",
            "for",
            "switch",
            "case",
          },
        },
      },
    },
  },
}
