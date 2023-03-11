local lsp = require('lsp-zero')
local schemastore = require('schemastore')
local schemas = schemastore.json.schemas()

lsp.preset('recommended')

lsp.ensure_installed {
  'ansiblels',
  'awk_ls',
  'bashls',
  'clangd',
  'dockerls',
  'elixirls',
  'eslint',
  'html',
  'hls',
  'jdtls',
  'jsonls',
  'pyright',
  'rust_analyzer',
  'lua_ls',
  'terraformls',
  'tsserver',
  'vimls',
  'yamlls',
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
    },
  },
})

lsp.configure('jsonls', {
  settings = {
    json = schemas,
  },
})

lsp.configure('yamlls', {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = false,
      schemas = schemas,
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
  _G.map('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "Rename" })
  _G.map('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, remap = false, desc = "Code actions" })
  _G.map('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, remap = false, desc = "Format file" })
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

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
