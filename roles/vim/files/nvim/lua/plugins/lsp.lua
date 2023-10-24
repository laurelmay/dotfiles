return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
        awk_ls = {},
        bashls = {},
        html = {},
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "go", vim.lsp.buf.type_definition, desc = "Go to type definition" }
      keys[#keys + 1] = { "gr", vim.lsp.buf.references, desc = "Go to references" }
      keys[#keys + 1] = {
        "<F3>",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format file (async)",
      }
      keys[#keys + 1] = { "<F4>", vim.lsp.buf.code_action, desc = "Show code actions" }
      keys[#keys + 1] = { "<space>e", vim.diagnostic.open_float, desc = "Show diagnostic details" }
      keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Show diagnostic details" }
      keys[#keys + 1] = { "<F2>", vim.lsp.buf.rename, desc = "Rename" }
      keys[#keys + 1] = { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" }
      keys[#keys + 1] = { "<leader>f", vim.lsp.buf.format, desc = "Format file" }
    end,
  },
}
