" NVIm config file
"
" Vim Plug plugin configuration
"
call plug#begin('~/.config/nvim/data/plugged')

" Vim-Airline
Plug 'vim-airline/vim-airline'

" Deoplete
" Completion engine thingy
Plug 'Shougo/deoplete.nvim'

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
" let g:deoplete#enable_at_startup = 1
" <Tab>: Completion
inoremap <expr><TAB> pumvisible() ? "\<c-n>" :"\<TAB>"

" Vim Airline Theme Stuff
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" Powerline Symbols

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
