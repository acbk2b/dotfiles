" NVIm config file
"
" Vim Plug plugin configuration
"
call plug#begin('~/.config/nvim/data/plugged')

" Vim-Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Dracula Color Scheme
Plug 'dracula/vim',{'as':'dracula'}

call plug#end()

" General Stuff

" Enable Syntax Highlighting
syntax enable

" Set all of the tab spacing settings to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Use mouse
set mouse=a

" Show line numbers (hybrid)
set number
set relativenumber

" turn off swap files
set noswapfile
set nobackup
set nowritebackup

" Color Scheme
colorscheme dracula

" Custom keymaps

" Move between split panes using the Alt key
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Plugin Configuration

" Vim Airline Theme Stuff
let g:airline_powerline_fonts = 1

" Coc stuff
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
