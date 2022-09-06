-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end
local lsp_flags = {}

vim.g.coq_settings = {
  auto_start = 'shut-up',
  xdg = true,
  match = {
    exact_matches = 0,
  },
}
local lsp = require "lspconfig"
local coq = require "coq"

require "mason".setup {}
require "mason-lspconfig".setup {
  automatic_installation = true,
}

local function ts_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- Map server names to the additional settings for that particular
-- language server (many won't have additional settings)
local lsp_configs = {
  ansiblels = {},
  clangd = {},
  bashls = {},
  elixirls = {},
  pyright = {},
  tsserver = {
    commands = {
      OrganizeImports = {
        ts_organize_imports,
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
          globals = {'vim'}
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
        schemas = require "schemastore".json.schemas(),
      },
    },
  },
}

for server, settings in pairs(lsp_configs) do
  local server_config = { on_attach = on_attach, flags = lsp_flags }
  local full_config = vim.tbl_extend('force', server_config, settings)
  lsp[server].setup(coq.lsp_ensure_capabilities(full_config))
end
