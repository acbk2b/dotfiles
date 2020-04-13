" NVIm config file
" General Stuff
syntax enable
colorscheme desert
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" filetype on
" set nu
" set ruler
" Use mouse
set mouse=a
" set list

set number

" Custom Mappings
map LLPStartPreview :llp

"
" Vim Plug plugin configuration
"
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

"
" vim-plug
" 
call plug#begin('~/.config/nvim/data/plugged')

" Vim-Airline
Plug 'vim-airline/vim-airline'

" Deoplete
" Completion engine thingy
Plug 'Shougo/deoplete.nvim'

" LaTeX Live Preview plugin
Plug 'xuhdev/vim-latex-live-preview'

call plug#end()

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
