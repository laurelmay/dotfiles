local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
_G.map = map

-- Allow switching buffers easier
map('n', 'gb', ':ls<CR>:b<Space')
map('n', '<Tab>', ':bn<CR>')
map('n', '<S-Tab>', ':bp<CR>')

-- Keep selection after (de)indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Remove trailing whitespace
map('n', '<F5>', [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]])

-- Clear search
map('n', '<leader>c', ':nohls<CR>')
