call plug#begin('~/.config/nvim/plugged')

Plug 'jacoborus/tender.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ziglang/zig.vim'
Plug 'preservim/nerdtree'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'luochen1990/rainbow'
Plug 'zah/nim.vim'
Plug 'windwp/nvim-autopairs'

call plug#end()

set relativenumber
set number
set foldmethod=indent
" Visually make tabs 4 spaces
set shiftwidth=0
set softtabstop=-1
set tabstop=4
set expandtab
" Use tab to select suggestions
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
syntax on

" Refresh Coc
map <f5> :CocRestart<CR><CR>

colorscheme tender

nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:rainbow_active = 1

" Hexokinase
let g:Hexokinase_highlighters = [ 'virtual' ]
set termguicolors

" nim.vim requirement
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" autopairs
lua << EOF
require("nvim-autopairs").setup {}
EOF
