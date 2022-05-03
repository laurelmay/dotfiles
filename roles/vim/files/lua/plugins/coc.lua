local code = {}

function code.check_back_space()
  local col = vim.fn.col('.') - 1
  return col <= 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

map('i', '<TAB>', [[pumvisible() ? "\<C-n>" : v:lua.config.code.check_back_space() ? "\<TAB>" : coc#refresh()]], { expr = true })
map('i', '<S-TAB>', [[pumvisible() ? "\<C-p>" : "\<C-h>"]], { expr = true })

-- use <c-space> to trigger completion
map('i', '<c-space>', 'coc#refresh()', { expr = true })
-- make <CR> auto-slect the first completion and reformat
map('i', '<cr>', [[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { expr = true })

-- Navigate diagnostics
-- Use :CocDiagnostics to get all diagnostics of the current buffer in location list
map('n', '[g', '<Plug>(coc-diagnostic-prev)')
map('n', ']g', '<Plug>(coc-diagnostic-next)')

-- Code navigation
map('n', 'gd', '<Plug>(coc-definition)')
map('n', 'gy', '<Plug>(coc-type-definition)')
map('n', 'gi', '<Plug>(coc-implementation)')
map('n', 'gr', '<Plug>(coc-refeferences)')

-- K to show documentation
map('n', 'K', ':call v:lua.config.code.show_documentation()<CR>')
function code.show_documentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.fn.feedkeys('K', 'in')
  end
end

-- Highlight all occurrences of symbol on cursorhold
vim.cmd [[
autocmd CursorHold * silent call CocActionAsync('highlight')
]]

-- Rename
map('n', '<leader>rn', '<Plug>(coc-rename)')

-- Format code
map('x', '<leader>f', '<Plug>(coc-format-selected)')
map('n', '<leader>f', '<Plug>(coc-format-selected)')

vim.cmd [[
augroup cocformat
  autocmd!
  " Setup formatexpr for specified file type(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
]]

map('x', '<leader>a', '<Plug>(coc-codeaction-selected)')
map('n', '<leader>a', '<Plug>(coc-codeaction-selected)')

-- Appy codeAction to the current buffer
map('n', '<leader>ac', '<Plug>(coc-codeaction)')
-- Apply autofix to the current line
map('n', '<leader>qf', '<Plug>(coc-fix-current)')

-- Run codelens
map('n', '<leader>cl', '<Plug>(coc-codelens-action)')

-- Map function and class text objects
map('x', 'if', '<Plug>(coc-funcobj-i)')
map('o', 'if', '<Plug>(coc-funcobj-i)')
map('x', 'af', '<Plug>(coc-funcobj-a)')
map('o', 'af', '<Plug>(coc-funcobj-a)')
map('x', 'ic', '<Plug>(coc-classobj-i)')
map('o', 'ic', '<Plug>(coc-classobj-i)')
map('x', 'ac', '<Plug>(coc-classobj-a)')
map('o', 'ac', '<Plug>(coc-classobj-a)')

-- Use Ctrl-S for selections ranges
map('n', '<C-s>', '<Plug>(coc-range-select)')
map('x', '<C-s>', '<Plug>(coc-range-select)')

-- Remap <C-f> and <C-b> for scroll float windows/popups
map('n', '<C-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], { nowait = true })
map('n', '<C-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], { nowait = true })
map('i', '<C-f>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]], { nowait = true })
map('i', '<C-b>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]], { nowait = true })
map('v', '<C-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]], { nowait = true })
map('n', '<C-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]], { nowait = true })


vim.cmd [[
command! -nargs=? Fold :call   CocAction('fold', <f-args>)
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 OR   :call   CocActionAsync('runCommand', 'editor.action.organizeImport')
nnoremap <F6> :Format<CR>:OR<CR>
]]

_G.config.code = code
