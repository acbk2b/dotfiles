" NVIm config file
" General Stuff
syntax enable
colorscheme desert
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
filetype on
set nu
set ruler
set mouse=a
set list

" vim-plug
call plug#begin('~/.config/nvim/data/plugged')

" Semshi
" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Vim-Airline
" Purty status bar
Plug 'vim-airline/vim-airline'

" Deoplete
" Completion engine thingy
Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"
call plug#end()

" Deoplete
let g:deoplete#enable_at_startup = 1
" <Tab>: Completion
inoremap <expr><TAB> pumvisible() ? "\<c-n>" :"\<TAB>"

" Vim Airline Theme Stuff
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

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