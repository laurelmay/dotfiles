require('neogen').setup {
  snippet_engine = "luasnip",
  languages = {
    python = {
      template = {
        annotation_convention = "reST"
      }
    }
  }
}

_G.map("n", "<Leader>nf", function() require('neogen').generate() end, { desc = "Generate annotation" })
