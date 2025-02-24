" Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
    let g:lightline = {'colorscheme': 'nord'}
call plug#end()

" General
syntax on
filetype plugin indent on
set nocompatible
set noundofile
set belloff=all
set backspace=indent,eol,start
set encoding=utf-8
set linebreak
set number
set splitbelow splitright
set pumheight=15
set signcolumn=yes
colorscheme nord

" Indenting
set indentexpr="" " disable auto-inserting tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cindent

" Mappings
nnoremap <C-n> <cmd>tabn<cr>
nnoremap <C-p> <cmd>tabp<cr>
nnoremap <C-\> <cmd>NERDTreeToggle<cr>
inoremap <C-\> <ESC>:NERDTreeToggle<cr>
