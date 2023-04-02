return {
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signcolumn = false,
      numhl = true,
      linehl = false,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 250,
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          _G.map(mode, l, r, opts)
        end

        -- Actions
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
        map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Blame line" })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle blame for line" })
        map('n', '<leader>hd', gs.diffthis, { desc = "Git diff" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff to HEAD" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted lines" })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },
  {
    'andweeb/presence.nvim',
    opts = {
      -- don't show presence information at work
      blacklist = (vim.startswith(vim.fn.hostname(), 'edc-') and { '**' }) or {},
    }
  }
}
