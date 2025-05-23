filetype plugin indent on
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_paste = 1
let g:airline_powerline_fonts = 1
set autoindent
set backspace=indent,eol,start
"set clipboard=autoselect
set clipboard=unnamedplus
set confirm
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileformat=unix
set grepprg=rg\ --vimgrep\ -uu\ --no-heading\ --smart-case
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set modeline
"set mouse=a
"set mousemodel=popup
set nocompatible
"set noswapfile
"set nobackup
set number relativenumber
set nocursorline
set path+=**
set ruler
set scrolloff=8
set shiftround
set shiftwidth=4
set showcmd
set showmatch
set showmode
set smartcase
set softtabstop=0
"set spell! spelllang=en_us
"set spell
set spelllang=en_us
set tabstop=4
set termbidi
"set termguicolors
set title
set undolevels=1000
set wildmenu
set wildmode=longest,list,full
set wrap linebreak nolist
syntax on

" Half Page Moving + Cursor in the middle of the page
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

" Next/Previous in Search + Cursor in the middle of the page
nnoremap("n", "nzz")
nnoremap("N", "Nzz")

" Allow moving the cursor through wrapped lines with j, k
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" Change Leader Key to Space
let g:mapleader = " "
let maplocalleader = " "
