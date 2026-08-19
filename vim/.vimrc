let &t_SI = "\e[5 q"  " bar cursor in insert mode
let &t_EI = "\e[2 q"  " block cursor in normal mode
let &t_SR = "\e[3 q"  " underline in replace modeset nocompatible

syntax on

filetype on

filetype indent on

filetype plugin on
set cursorline
set cursorcolumn

set shortmess+=I

set number

set relativenumber

set laststatus=2

set backspace=indent,eol,start
set scrolloff=10

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set showmatch
set hlsearch
set ignorecase
set smartcase
set incsearch

set shiftwidth=4
set tabstop=4

if has('macunix')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

nnoremap <space>w :w<cr>
nnoremap <space>q :q<cr>
nnoremap <space>x :wq<cr>
inoremap <space>jk <esc>
inoremap <space>kj <esc>
vnoremap <space>jk <esc>
vnoremap <space>kj <esc>

call plug#begin('~/.vim/plugged')
	Plug 'dense-analysis/ale'

  	Plug 'preservim/nerdtree'
call plug#end()
