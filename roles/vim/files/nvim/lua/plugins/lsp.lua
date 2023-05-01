return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        ansiblels = {},
        awk_ls = {},
        bashls = {},
        clangd = {},
        dockerls = {},
        html = {},
        jdtls = {},
        pyright = {},
        yamlls = {
          settings = {
            yaml = {
              hover = true,
              completion = true,
              validate = false,
              -- These tags are only really useful if using AWS CloudFormation
              customTags = {
                "!Cidr",
                "!Cidr sequence",
                "!And",
                "!And sequence",
                "!If",
                "!If sequence",
                "!Not",
                "!Not sequence",
                "!Equals",
                "!Equals sequence",
                "!Or",
                "!Or sequence",
                "!FindInMap",
                "!FindInMap sequence",
                "!Base64",
                "!Join",
                "!Join sequence",
                "!Ref",
                "!Sub",
                "!Sub sequence",
                "!GetAtt",
                "!GetAZs",
                "!ImportValue",
                "!ImportValue sequence",
                "!Select",
                "!Select sequence",
                "!Split",
                "!Split sequence",
              },
            },
          },
        },
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", vim.lsp.buf.hover, desc = "Show hover" }
      keys[#keys + 1] = { "gd", vim.lsp.buf.definition, desc = "Go to definition" }
      keys[#keys + 1] = { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" }
      keys[#keys + 1] = { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" }
      keys[#keys + 1] = { "go", vim.lsp.buf.type_definition, desc = "Go to type definition" }
      keys[#keys + 1] = { "gr", vim.lsp.buf.references, desc = "Go to references" }
      keys[#keys + 1] = { "gs", vim.lsp.buf.signature_help, desc = "Show signature" }
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
      keys[#keys + 1] = { "[d", vim.diagnostic.goto_prev, desc = "Go to prev diagnostic" }
      keys[#keys + 1] = { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic" }
      keys[#keys + 1] = { "<F2>", vim.lsp.buf.rename, desc = "Rename" }
      keys[#keys + 1] = { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" }
      keys[#keys + 1] = { "<leader>ca", vim.lsp.buf.code_action, desc = "Show code actions" }
      keys[#keys + 1] = { "<leader>f", vim.lsp.buf.format, desc = "Format file" }
    end,
  },
}
