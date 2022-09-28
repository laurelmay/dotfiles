-- These are plugins that are used within this module. All of
-- them are required for LSP and completion to work as expected.
local telescope = require'telescope.builtin'
local lsp = require "lspconfig"
local schemastore = require "schemastore"
local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local cmp = require "cmp"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local mason_null_ls = require "mason-null-ls"
local null_ls = require "null-ls"

-- These are LSP-related key mappings that are applied globally.
_G.map('n', '<space>e', vim.diagnostic.open_float)
_G.map('n', '<space>d', telescope.diagnostics)
_G.map('n', '[d', vim.diagnostic.goto_prev)
_G.map('n', ']d', vim.diagnostic.goto_next)
_G.map('n', '<space>q', vim.diagnostic.setloclist)

-- This function is run in the `on_attach` event for each language server to set up
-- additional key mappings. Primarily, these deal with LSP features and mappings.
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { buffer = bufnr }
  _G.map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  _G.map('n', 'gd', telescope.lsp_definitions, bufopts)
  _G.map('n', 'gU', telescope.lsp_references, bufopts)
  _G.map('n', 'K', vim.lsp.buf.hover, bufopts)
  _G.map('n', 'gi', telescope.lsp_implementations, bufopts)
  _G.map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  _G.map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  _G.map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  _G.map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  _G.map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  _G.map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  _G.map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  _G.map('n', 'gr', vim.lsp.buf.references, bufopts)
  _G.map('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

mason.setup {}
mason_lspconfig.setup { automatic_installation = true }

-- This maps each of the language server names that are configured as part of `lspconfig`
-- to the settings that are used for each; many do not require additional settings but others
-- may have more involved overrides
local lsp_configs = {
  ansiblels = {},
  clangd = {},
  bashls = {},
  elixirls = {},
  pyright = {},
  tsserver = {
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
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy'
        }
      }
    }
  },
  jdtls = {
    root_dir = function()
      return vim.fn.getcwd()
    end
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          globals = { 'vim' }
        },
      },
    }
  },
  dockerls = {},
  yamlls = {
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
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
  },
}

-- Set the capabilities for each of the language servers, primarily for the purpose of
-- adding completion support
local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.update_capabilities(base_capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- These are the base settings generally for each language server. They're applied globally
-- to the default config for the LSP Config plugin.
local base_lsp_config = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  on_attach = on_attach,
}
lsp.util.default_config = vim.tbl_deep_extend(
  'force',
  lsp.util.default_config,
  base_lsp_config
)
-- Actually setup of each of the language server implementations defined above
for server, settings in pairs(lsp_configs) do
  lsp[server].setup(settings)
end

-- Configure completion using nvim-cmp and luasnip
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 2, },
    { name = 'nvim_lua' },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  completion = {
    keyword_length = 1,
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = lspkind.cmp_format {
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        nvim_lua = "[nvim]",
      }),
    },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Esc>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and (
            vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            )
      end

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  experimental = {
    ghost_text = true,
  },
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

-- Configure various null-ls builtins using the mason installer. The installer
-- plugin must be configured before null-ls itself. 
mason_null_ls.setup {
  automatic_installation = true,
  auto_update = true,
}
null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.alex,
    -- JavaScript/TypeScript
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettier,
    -- Shell
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    -- Markdown
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
  }
}
