" PLUGINS
call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" defaults
set smarttab expandtab shiftwidth=4
set number norelativenumber
set cursorline

" spellcheck
set spelllang=en

" colors
set background=dark
colorscheme solarized

" scrolling
set scrolloff=5

" linewrap
set nowrap

" fix lightline
set laststatus=2
let g:lightline = { 'colorscheme': 'solarized' }
set noshowmode

if exists("+colorcolumn")
    set colorcolumn=80
    highlight ColorColumn ctermbg=DarkCyan guibg=DarkCyan
endif

" Live preview of :substitute
set inccommand=split

" NERDCommenter settings
let mapleader=","
let g:NERDSpaceDelims=1

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Configure syntastic settings
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" <F6> to make
map <F6> :make<CR>
imap <F6> <C-O>:make<CR>

" <F7> to make clean default test
map <F7> :make CC=gcc-5 clean default test<CR>
imap <F7> <C-O>:make CC=gcc-5 clean default test<CR>

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" backup and undo files
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
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

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78 shiftwidth=2 tabstop=2
  autocmd FileType java  setlocal shiftwidth=4 tabstop=4
  autocmd FileType c,cpp setlocal shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
  autocmd FileType haskell setlocal shiftwidth=2 tabstop=2

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

