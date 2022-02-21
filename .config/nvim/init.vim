call plug#begin('~/.config/nvim/bundle')
" VIM enhancments
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
" Plug 'andymass/vim-matchup'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Git support
Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'

Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Fuzzy search
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language support
" TOML
Plug 'cespare/vim-toml'
" Install: https://rust-analyzer.github.io/manual.html#vimneovim 
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" python black formatter
Plug 'psf/black', { 'branch': 'stable' }
" Markdown
Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" RestructeredText
" Plug 'Rykka/riv.vim'
" Plug 'Rykka/InstantRst'
" Plug 'matthew-brett/vim-rst-sections'
" AsciiDoc Support
" Plug 'dahu/vimple'
" Plug 'dahu/asif'
" Plug 'raimondi/vimregstyle'
" Plug 'dahu/vim-asciidoc'
" Log Highlighting
Plug 'mtdl9/vim-log-highlighting'
" Latex plugins
Plug 'lervag/vimtex'
" Plug 'Konfekt/FastFold'
" Plug 'matze/vim-tex-fold'

" === Vim Color Themes ===
Plug 'chriskempson/base16-vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'morhetz/gruvbox'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'tyrannicaltoucan/vim-deep-space'




" =============================================================
" I should probably remove the rest of the plugins. 
" I leave it there for now. we'll see.

" Desktop and editor setup for Rust development by Jon Gjengset
" Plug 'w0rp/ale'

" Not need atm
" Plug 'vim-syntastic/syntastic'
" Plug 'jiangmiao/auto-pairs'

" Git. Not sure when I last used this.
Plug 'Xuyuanp/nerdtree-git-plugin'

" iptables highlighting
" Plug 'vim-scripts/iptables'

" Icons. Always load as last plugin
" Plug 'ryanoasis/vim-devicons'

" Multiple cursor. Standard is <C-n>. 
" Change that, since <C-n> is NerdTree here.
" See https://github.com/terryma/vim-multiple-cursors
" Plug 'terryma/vim-multiple-cursors'
"
call plug#end()

" Theme and colors
let base16colorspace=256
set background=dark
set termguicolors
syntax enable

" let g:gruvbox_contrast_dark = 'medium'
" colorscheme base16-atelier-dune
" colorscheme base16-irblack
" colorscheme base16-flat
" colorscheme base16-github
" colorscheme base16-gruvbox-dark-medium
colorscheme base16-solarized-dark

" let g:airline_theme='deep_space'
let g:airline_theme='base16_atelierdune'
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Coc settings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>
" END COC SETTINGS


" Vim Rooter - Dont echo project directory
let g:rooter_silent_chdir = 1
" list of string which identify root dirs
let g:rooter_patterns = ['.git']
" root hast direct parent dir 'Projects'
" let g:rooter_patterns = ['Projects']

:let mapleader = ","

" Sane splits
set splitright
set splitbelow

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remapping ESC to jk
inoremap jk <ESC>

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
map <C-f> :NERDTreeFocus<CR>
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
set numberwidth=4
" set relativenumber
set incsearch
set ignorecase
set smartcase
nnoremap <C-h> :nohlsearch<CR>
vnoremap <C-h> :nohlsearch<CR>
set signcolumn=yes

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
set scrolloff=2
" don't break in the middle of words
set linebreak

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
" set autochdir

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

autocmd FileType markdown,asciidoc,c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

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

" Markdown Preview
" Do not close preview window when switching buffer in vim
let g:mkdp_auto_close = 0

nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop

" File types
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.md 
    \ set filetype=markdown |
    \ set shiftwidth=2 |
    \ set tabstop=2

" Set the textwidth and auto line breaks (format option)
" autocmd FileType tex,text,markdown setlocal textwidth=80 colorcolumn=81 formatoptions+=t

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

" Tabularize
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" search for highlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
