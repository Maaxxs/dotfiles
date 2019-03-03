call plug#begin('~/.config/nvim/bundle')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
" Not need atm
" Plug 'kien/ctrlp.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'

" rust
Plug 'rust-lang/rust.vim'

" work with RestructeredText
" Plug 'Rykka/riv.vim'
" Plug 'matthew-brett/vim-rst-sections'

" Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" === Vim Color Themes ===
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tyrannicaltoucan/vim-deep-space'


" Icons
Plug 'ryanoasis/vim-devicons'

" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

" Multiple cursor. Standard is <C-n>. 
" TODO: Change that, since <C-n> is NerdTree here.
" See https://github.com/terryma/vim-multiple-cursors
" Plug 'terryma/vim-multiple-cursors'
"
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
" colorscheme gruvbox
colorscheme deep-space
set termguicolors

let g:airline_theme='deep_space'

:let mapleader = ","

" Vim Surround:
" replace: cs"'
" remove:  ds"
" create:  ysiw"
" wrap entire line: yss"


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
" set nohlsearch

" Tab settings
set tabstop=2
set softtabstop=0
set shiftwidth=2
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

" from https://defuse.ca/vimrc.htm
" Make CTRL+u and CTRL+d less confusing
map <C-u> 10<C-Y>10k
map <C-d> 10<C-E>10j

" nnoremap <C-e> 5<C-e>
" nnoremap <C-y> 5<C-y>

" Switch windows quickly with CTRL+{h,j,k,l}
" This breaks backspace in a terminal, but I never use backspace in
" normal mode
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Map the semicolon to colon, so you don't have to press <Shift+;>
noremap ; :
noremap ;qq :q!

" Keep the blog selected when moving right or left
vmap < <gv
vmap > >gv

" After a search, clear all the highlighted results
map <esc> :noh<cr>

" highlight current line
set cursorline

" Always show the status line
set laststatus=2

" Use clipboard 
set clipboard+=unnamedplus

" Shortcuts for fzf, Ag ... 
map <C-p> :FZF<CR> 
map <leader>a :Ag<CR>
" TODO Mabe add <leader>r for that regex search which I have to install though
" map <leaer>r :Rg
" See https://github.com/BurntSushi/ripgrep
map <leader>h :History
" map <leader>l :Lines<CR>

" Remeber cursor position between vim sessions
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
" Center buffer around cursor when opening files
autocmd BufRead * normal zz

" auto change terminal's cwd to the current file
set autochdir

map <leader><leader>g :!asciidoctor-pdf %<CR>

