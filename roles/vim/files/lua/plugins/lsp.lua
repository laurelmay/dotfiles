
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      'b0o/schemastore.nvim',
    },
    config = function ()
      local servers = {
        'ansiblels',
        'awk_ls',
        'bashls',
        'clangd',
        'dockerls',
        'elixirls',
        'eslint',
        'html',
        'jdtls',
        'jsonls',
        'pyright',
        'lua_ls',
        'terraformls',
        'tsserver',
        'vimls',
        'yamlls',
      }
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = servers,
      }
      require('mason-lspconfig').setup_handlers({
        function(server)
          lspconfig[server].setup({})
        end,
        ['tsserver'] = function()
          lspconfig.tsserver.setup {
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
            },
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
          }
        end,
        ['yamlls'] = function()
          lspconfig.yamlls.setup {
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
          }
        end,
        ['jsonls'] = function ()
          lspconfig.jsonls.setup {
            settings = {
              json = schemas,
            },
          }
        end,
      })
      local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_cmds,
        desc = 'LSP actions',
        callback = function(args)
          local function map(mode, lhs, rhs, desc)
            _G.map(mode, lhs, rhs, { buffer = args.buf, remap = false, desc = desc })
          end
          map('n', 'K', vim.lsp.buf.hover, "Show hover")
          map('n', 'gd', vim.lsp.buf.definition, "Go to definition")
          map('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
          map('n', 'gi', vim.lsp.buf.implementation, "Go to implementation")
          map('n', 'go', vim.lsp.buf.type_definition, "Go to type definition")
          map('n', 'gr', vim.lsp.buf.references, "Go to references")
          map('n', 'gs', vim.lsp.buf.signature_help, "Show signature")
          map({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, "Format file (async)")
          map('n', '<F4>', vim.lsp.buf.code_action, "Show code actions")
          map('n', '<space>e', vim.diagnostic.open_float, "Show diagnostic details")
          map('n', 'gl', vim.diagnostic.open_float, "Show diagnostic details")
          map('n', '[d', vim.diagnostic.goto_prev, "Go to prev diagnostic")
          map('n', ']d', vim.diagnostic.goto_next, "Go to next diagnostic")
          map('n', '<F2>', vim.lsp.buf.rename, "Rename")
          map('n', '<leader>rn', vim.lsp.buf.rename, "Rename")
          map('n', '<leader>ca', vim.lsp.buf.code_action, "Show code actions")
          map('n', '<leader>f', vim.lsp.buf.format, "Format file")
        end
      })
    end
  },
}
