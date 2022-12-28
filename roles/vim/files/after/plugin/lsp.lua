local lsp = require('lsp-zero')
local schemastore = require('schemastore')

lsp.preset('recommended')

lsp.ensure_installed {
  'tsserver',
  'ansiblels',
  'clangd',
  'bashls',
  'elixirls',
  'pyright',
  'rust_analyzer',
  'sumneko_lua',
  'dockerls',
  'yamlls',
  'jdtls',
}

lsp.configure('tsserver', {
  commands = {
    OrganizeImports = {
      function()
        vim.lsp.buf.execute_command {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
      end,
      description = "Organize Imports"
    }
  }
})

lsp.configure('yamlls', {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = false,
      schemas = schemastore.json.schemas(),
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
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  _G.map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  _G.map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  _G.map('n', '<leader>f', vim.lsp.buf.format, opts)
end)

lsp.nvim_workspace()

local rust_lsp = lsp.build_options('rust_analyzer', {
  settings = {
    ["rust-analyzer"] = {
      -- Workaround for simrat39/rust-tools.nvim#300
      inlayHints = { locationLinks = false },
      checkOnSave = { command = "clippy" },
    },
  },
})

lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}

require('rust-tools').setup {
  server = rust_lsp,
}
