call plug#begin('~/.config/nvim/bundle')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'
Plug 'vim-syntastic/syntastic'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" Theme
set background=dark
syntax enable
colorscheme gruvbox

" Mapping keys
map <C-n> :NERDTreeToggle<CR>

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
" set tabstop=4
" set softtabstop=0
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
" set nowrap
set cc=79



