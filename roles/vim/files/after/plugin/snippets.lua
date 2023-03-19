local ls = require("luasnip")

ls.setup {
  history = true,
  delete_check_events = "TextChanged",
}

require("luasnip.loaders.from_vscode").lazy_load()

_G.map("i", "<Tab>", function() return ls.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>" end, { expr = true, silent = true })
_G.map("s", "<Tab>", function() ls.jump(1) end)
_G.map({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end)
