return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        awk_ls = {},
        html = {},
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<space>e", vim.diagnostic.open_float, desc = "Show diagnostic details" }
      keys[#keys + 1] = { "<F2>", vim.lsp.buf.rename, desc = "Rename" }
      keys[#keys + 1] = { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" }
    end,
  },
}
