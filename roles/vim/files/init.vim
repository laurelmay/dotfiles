" vim: set ft=vim:

"""
" PLUGINS
"""
call plug#begin()
Plug 'iCyMind/NeoSolarized'              " Truecolor Solarized theme
Plug 'Yggdroot/indentLine'               " Thin vertical lines at indents
Plug 'vim-airline/vim-airline'           " Needed for buffer display
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kylelaker/riscv.vim'
Plug 'kylelaker/cisco.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

"""
" BASIC VIM SETTINGS
"""

set nocompatible
set encoding=utf-8
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=number

" Required for lots of vim things

syntax on

" Indent settings
set smarttab expandtab shiftwidth=4

" Show numbers in gutter but not relative numbers
set number norelativenumber

" Highlight the line with the cursor
set cursorline

" spellcheck
set spelllang=en

" Solarized Dark theme
set termguicolors
colorscheme NeoSolarized
set background=light

" Scrolling
set scrolloff=5

" Disable line wrap
set nowrap

" Bar at 100 characters
if exists("+colorcolumn")
    set colorcolumn=100
    highlight ColorColumn ctermbg=DarkCyan guibg=DarkCyan
endif

" Enabled only when using neovim
" Live preview of :substitute.
set inccommand=split

"""
" PLUGIN SETTINGS
"""

" Show buffers at top of screen.
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" Use powerline fonts for airline
let g:airline_powerline_fonts = 1

"""
" KEY MAPPINGS
"""

" Quicker buffer switching
nnoremap gb :ls<CR>:b<Space>
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" keep selection after shifting with < or >
vnoremap < <gv
vnoremap > >gv

" CoC mappings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=? Fold :call   CocAction('fold', <f-args>)
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 OR   :call   CocActionAsync('runCommand', 'editor.action.organizeImport')
nnoremap <F6> :Format<CR>:OR<CR>

"""
" BACKUP/UNDO FILES
"""

" backup and undo files
" files will be stored in ~/.config/nvim/undodir (set by Ansible)
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
  set nowritebackup
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir-=.
  set backupdir^=~/.config/nvim/undodir
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
    set undodir-=.
    set undodir^=~/.config/nvim/undodir
  endif
endif

"""
" LANGUAGE PREFERENCES
"""

augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78 shiftwidth=2 tabstop=2
    autocmd FileType java  setlocal shiftwidth=4 tabstop=4
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
    autocmd FileType c,cpp setlocal shiftwidth=4 tabstop=4
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
    autocmd FileType haskell setlocal shiftwidth=2 tabstop=2
augroup END
