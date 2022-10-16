-- These are plugins that are used within this module. All of
-- them are required for LSP and completion to work as expected.
local lsp = require "lspconfig"
local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local cmp_nvim_lsp = require "cmp_nvim_lsp"

mason.setup {}
mason_lspconfig.setup { automatic_installation = true }

-- Set the capabilities for each of the language servers, primarily for the purpose of
-- adding completion support
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- These are the base settings generally for each language server. They're applied globally
-- to the default config for the LSP Config plugin.
lsp.util.default_config = vim.tbl_deep_extend(
  'force',
  lsp.util.default_config,
  {
    flags = { debounce_text_changes = 150 },
    capabilities = capabilities,
    --- @diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      _G.lsp.buffer_keymap(bufnr)
    end,
  }
)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

-- Actually setup of each of the language server implementations defined above
for server, settings in pairs(require('plugins.lsp.servers')) do lsp[server].setup(settings) end
