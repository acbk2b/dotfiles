" NVIm config file
"
" Vim Plug plugin configuration
"
call plug#begin('~/.config/nvim/data/plugged')

" Vim-Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Deoplete
" Completion engine thingy
Plug 'Shougo/deoplete.nvim'
" Python integration with jedi
Plug 'zchee/deoplete-jedi'

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

" Show line numbers
set number

" turn off swap files
set noswapfile
set nobackup

" Color Scheme
colorscheme dracula

" Custom keymaps

" Move between split panes using the Alt key
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Plugin Configuration

" Deoplete
let g:deoplete#enable_at_startup = 1
" <Tab>: Completion
inoremap <expr><TAB> pumvisible() ? "\<c-n>" :"\<TAB>"

" Vim Airline Theme Stuff
let g:airline_powerline_fonts = 1
