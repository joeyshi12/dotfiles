" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex', {'tag': 'v1.6'}
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
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
let delimitMate_expand_cr = 2 " Expand inside brackets

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:ultisnips_python_quoting_style="double"

" LSP
let g:coc_disable_transparent_cursor = 1
let g:ale_disable_lsp = 1

" Indenting
set indentexpr="" " disable auto-inserting tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cindent

" Colour scheme
colorscheme catppuccin
let g:lightline = {'colorscheme': 'catppuccin'}

" LaTeX
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
set conceallevel=2
let g:tex_conceal = 'abdmg'

" Mappings
nnoremap <C-n> :tabn<cr>
nnoremap <C-p> :tabp<cr>
nnoremap <C-\> :NERDTreeToggle<cr>
inoremap <C-\> <ESC>:NERDTreeToggle<cr>
vnoremap <C-c> "+y
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>ec <Plug>(coc-config)
nnoremap <leader>ft :TableFormat<cr>
nnoremap <leader>fj :%!python -m json.tool<cr>

nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <leader>gd <Plug>(coc-definition)
nnoremap ghp <Plug>(coc-git-chunkinfo)
nnoremap ghu :CocCommand git.chunkUndo<cr>

inoremap <nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" https://vi.stackexchange.com/questions/343/how-to-edit-binary-files-with-vim
"nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
"nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Autocommands
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup TRIM_WHITESPACE
  au!
  au BufWritePre * :call TrimWhitespace()
augroup END

augroup BINARY_FILETYPE
  au!
  au BufReadPost *.bin set ft=xxd
augroup END
