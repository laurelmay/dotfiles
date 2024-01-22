return {
  -- Add Vue to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vue" })
      end
    end,
  },
  -- Use the local volar setup and fallback to global TS server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = { 'typescript', 'javascript', 'vue', 'json' }
        },
      },
    },
  },
}
