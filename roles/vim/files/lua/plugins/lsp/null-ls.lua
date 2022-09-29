local mason_null_ls = require "mason-null-ls"
local null_ls = require "null-ls"

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
