call plug#begin('~/.config/nvim/plugged')

Plug 'jacoborus/tender.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ziglang/zig.vim'
Plug 'preservim/nerdtree'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'luochen1990/rainbow'

call plug#end()

set relativenumber
set number
set foldmethod=indent
" Use tab to select suggestions
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
syntax on

colorscheme tender

nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:rainbow_active = 1

" Hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]
