call plug#begin('~/.config/nvim/bundle')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'
Plug 'vim-syntastic/syntastic'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" Enable deoplete
let g:deoplete#enable_at_startup=1
" use Tab to go forwards
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use Shift + Tab to go backwards
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" close documentation window once completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Theme
set background=dark
syntax enable
colorscheme gruvbox

:let mapleader = ","

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" NERTCommenter
" press: 78GV88G <leader>c<space> -> comment lines 78-88
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERTCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1


" remapping ESC to jk
inoremap jk <ESC> 

" Y copies everything from cursor to end of line
noremap Y y$

set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch
" Tab settings
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab

" if smartindent is set, autoindent should be set as well
" set smartindent
" set autoindent

" another auto indenation, preferred for C
set cindent 

set nobackup
set noswapfile
" set nowrap
set colorcolumn=79
set scrolloff=7


