local schemastore = require "schemastore"

-- This maps each of the language server names that are configured as part of `lspconfig`
-- to the settings that are used for each; many do not require additional settings but others
-- may have more involved overrides
return {
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
  },
}


