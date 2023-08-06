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
set ffs=unix,dos,mac
set fileencoding=utf-8
set hidden
set history=1000
set hlsearch
set ignorecase smartcase
set incsearch
set laststatus=2
set modeline
"set mouse=a
"set mousemodel=popup
set nocompatible
"set noswapfile
"set nobackup
set number relativenumber
set path+=**
set ruler
set scrolloff=8
set shiftround
set shiftwidth=2
set showcmd
set showmatch
set showmode
set softtabstop=0
"set spell! spelllang=en_us
"set spell
"set spelllang=en_us
set tabstop=2
set termbidi
set termguicolors
set title
set undolevels=1000
set wildmenu
set wrap linebreak nolist
syntax on

" Half Page Moving + Cursor in the middle of the page
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

" Next/Previous in Search + Cursor in the middle of the page
nnoremap("n", "nzz")
nnoremap("N", "Nzz")

" Change Leader Key to Space
let g:mapleader=" "
