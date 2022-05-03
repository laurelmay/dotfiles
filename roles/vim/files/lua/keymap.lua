function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Allow switching buffers easier
map('n', 'gb', ':ls<CR>:b<Space')
map('n', '<Tab>', ':bn<CR>')
map('n', '<S-Tab>', ':bp<CR>')

-- Keep selection after (de)indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Remove trailing whitespace
map('n', '<F5>', [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]])

-- Reload configuration
map('n', '<leader>r', ':so %<CR>')

-- Clear search
map('n', '<leader>c', ':nohls<CR>')
