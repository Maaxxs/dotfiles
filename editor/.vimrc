" Theme
set background=dark
syntax enable
" colorscheme gruvbox
set termguicolors
:let mapleader = ","

" remapping ESC to jk
inoremap jk <ESC>

" Y copies everything from cursor to end of line
noremap Y y$

set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set mouse=a
" set nohlsearch

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

" from https://defuse.ca/vimrc.htm
" Make CTRL+u and CTRL+d less confusing
map <C-u> 10<C-Y>10k
map <C-d> 10<C-E>10j

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

" switch on/off spell checking
map <leader>sf :set nospell<cr>
map <leader>sn :set spell<cr>

" Keep the blog selected when moving right or left
vmap < <gv
vmap > >gv

" After a search, clear all the highlighted results
" map <esc> :noh<cr>

" Always show the status line
set laststatus=2

" Use clipboard 
set clipboard+=unnamedplus

" Remeber cursor position between vim sessions
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
" Center buffer around cursor when opening files
autocmd BufRead * normal zz

" auto change terminal's cwd to the current file
set autochdir

" Generate a pdf document from the current adoc file
map <leader><leader>g :!asciidoctor-pdf %<CR>

" Open the current file in firefox
map <leader><leader>f :!firefox %<CR>

" Function to strip whitespace at end of line
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType asciidoc,c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

autocmd FileType    log
                \   set cc=0 |
                \   set nowrap

autocmd BufEnter,WinEnter * 
    \ if getline(1) =~ "^# Generated by iptables-save" ||
    \ getline(1) =~ "^# Firewall configuration written by" |
        \ setfiletype iptables |
        \ set commentstring=#%s |
        \ set cc=0 |
    \ endif

