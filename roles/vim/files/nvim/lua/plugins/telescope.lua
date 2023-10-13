local function ts_builtin(builtin, opts)
  return function()
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  {
    "telescope.nvim",
    keys = {
      { "<leader>ff", ts_builtin("find_files"), desc = "Find files" },
      { "<leader>fg", ts_builtin("live_grep"), desc = "Grep workspace" },
      { "<leader>fb", ts_builtin("buffers"), desc = "Find buffer" },
      { "<leader>fh", ts_builtin("help_tags"), desc = "Find help tag" },
      { "gd", ts_builtin("lsp_definitions"), desc = "Go to definition" },
      { "gU", ts_builtin("lsp_references"), desc = "List references" },
      { "gi", ts_builtin("lsp_implementations"), desc = "Go to implementations" },
      { "<space>d", ts_builtin("diagnostics"), desc = "List diagnostics" },
    },
  },
}
