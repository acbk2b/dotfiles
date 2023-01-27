" NVim config file
"
" Vim Plug plugin configuration
"
call plug#begin('~/.config/nvim/data/plugged')

" Vim-Airline
Plug 'vim-airline/vim-airline'
" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Dracula Color Scheme
Plug 'dracula/vim', {'as':'dracula'}
" Markdown
" https://github.com/preservim/vim-markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" Easy Motion
Plug 'easymotion/vim-easymotion'
" File Tree
Plug 'preservim/nerdtree'

call plug#end()

" General Stuff

" Enable Syntax Highlighting
syntax enable

" Set all of the tab spacing settings to 2 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Fold method
set foldmethod=indent

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

" Visual block indent; keep block
vmap < <gv
vmap > >gv

" Macros
let @t = 'i`wea`'

" Plugin Configuration

" Vim Airline Theme Stuff
let g:airline_powerline_fonts = 1

" Coc
source ~/.config/nvim/coc-config.vim

" Nerd Tree
" Remaps
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Config
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
