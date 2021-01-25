call plug#begin('~/.config/nvim/bundle')
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
" Not need atm
" Plug 'kien/ctrlp.vim'
" Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'

" Rust
Plug 'rust-lang/rust.vim'
" Install: https://rust-analyzer.github.io/manual.html#vimneovim 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python 
Plug 'psf/black', { 'branch': 'stable' }

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Desktop and editor setup for Rust development by Jon Gjengset
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'

" work with RestructeredText
" Plug 'Rykka/riv.vim'
" Plug 'matthew-brett/vim-rst-sections'

" Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" === Vim Color Themes ===
Plug 'chriskempson/base16-vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tyrannicaltoucan/vim-deep-space'

" === AsciiDoc Support ===
" Plug 'dahu/vimple'
" Plug 'dahu/asif'
" Plug 'raimondi/vimregstyle'
" Plug 'dahu/vim-asciidoc'

" === Log Highlighting ===
Plug 'mtdl9/vim-log-highlighting'

" iptables highlighting
" Plug 'vim-scripts/iptables'

" Fuzzy search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Icons. Always load as last plugin
Plug 'ryanoasis/vim-devicons'

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
let base16colorspace=256
set background=dark
set termguicolors
syntax enable

" Gruvbox
" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'medium'

" Deepspace
" colorscheme deep-space

" Base16 
" colorscheme base16-default-dark
colorscheme base16-atelier-dune
" colorscheme base16-gruvbox-dark-medium
" colorscheme base16-tomorrow-night
" colorscheme base16-woodland


" let g:airline_theme='deep_space'
" let g:airline_theme='gruvbox'

" Vim Rooter - Dont echo project directory
let g:rooter_silent_chdir = 1

:let mapleader = ","

" remapping ESC to jk
inoremap jk <ESC>

" Ctrl+k as Esc
" So we also map Ctrl+k
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Vim Surround:
" replace: cs"'
" remove:  ds"
" create:  ysiw"
" wrap entire line: yss"

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
nnoremap <leader><leader> <c-^>

" Quick Save
nmap <leader>w :w<CR>

" Permanent Undo 
set undodir=~/.vimdid
set undofile


" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" NERTCommenter
" press: 78GV88G <leader>c<space> -> comment lines 78-88
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERTCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1

" Y copies everything from cursor to end of line
noremap Y y$

set number
set relativenumber
set incsearch
set ignorecase
set smartcase
nnoremap <C-h> :nohlsearch<CR>
vnoremap <C-h> :nohlsearch<CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Tab settings
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab

filetype plugin indent on
" if smartindent is set, autoindent should be set as well
" set smartindent
set autoindent

" another auto indenation, preferred for C
" set cindent

set nobackup
set noswapfile
" set nowrap
set colorcolumn=80
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
" map <C-h> <C-W>h
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-l> <C-W>l

" Map the semicolon to colon, so you don't have to press <Shift+;>
noremap ; :
noremap ;qq :q!

" switch on/off spell checking
map <leader>sf :set nospell<cr>
map <leader>sn :set spell<cr>
set timeoutlen=300

" Keep the blog selected when moving right or left
vmap < <gv
vmap > >g

" After a search, clear all the highlighted results
map <esc> :noh<cr>

" highlight current line
set cursorline

" Always show the status line
set laststatus=2

" Use clipboard 
set clipboard+=unnamedplus

" Use mouse scrolling for vim instead tmux terminal
set mouse=a

" Shortcuts for fzf, Ag ... 
" map <C-p> :FZF<CR>
" map <leader>a :Ag<CR>
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

" Ripgrep search
noremap <leader>s :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

" Reload nvim config
map <leader>r :source ~/.config/nvim/init.vim<CR>



" File types
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.md set filetype=markdown

" Set the textwidth and auto line breaks (format option)
autocmd FileType tex,text,markdown setlocal textwidth=80 colorcolumn=81 formatoptions+=t

" Markdown Folding
" Have not folding when opening a file
set nofoldenable

""""" Programming Lanuages """""
" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
au Filetype rust set colorcolumn=100

" ### Python
" Auto format on write
autocmd BufWritePre *.py execute ':Black'

" M to make 
noremap M :!make -k -j4<CR>

" Use mouse to scroll inside of tmux
set mouse=a

