let mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')
" VIM enhancments
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
" Plug 'andymass/vim-matchup' "extend vim % key to language specific words
Plug 'ntpeters/vim-better-whitespace' "Highlight trailing whitespace
Plug 'tpope/vim-commentary' "smart commenter

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'luukvbaal/nnn.nvim'
"Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/nerdcommenter'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Fuzzy search
Plug 'airblade/vim-rooter'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug '/usr/bin/fzf'
" Plug 'junegunn/fzf.vim'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'} " path completion
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'ray-x/lsp_signature.nvim'
" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" " maybe that too:
" Plug 'hrsh7th/cmp-cmdline' "cmp cmdline completion
" Plug 'simrat39/rust-tools.nvim' "extra functionality over rust analyzer

" Syntactic Language support
Plug 'cespare/vim-toml'
" Install: https://rust-analyzer.github.io/manual.html#vimneovim
Plug 'rust-lang/rust.vim'

" python black formatter
" Plug 'psf/black', { 'branch': 'stable' } " TODO: check Neoformat.remove if
" there
"
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
" Plug 'lervag/vimtex'
" Plug 'Konfekt/FastFold'
" Plug 'matze/vim-tex-fold'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'sbdchd/neoformat' "formatter
" Plug 'norcalli/nvim-colorizer.lua' "colorize color names and hex values
Plug 'chriskempson/base16-vim' "base16 color themes

Plug 'vim-scripts/iptables' "iptables highlighting
Plug 'ryanoasis/vim-devicons' "icons. Always load as last plugin
call plug#end()

" LSP configuration
lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	postfix = {
	  enable = false,
	},
      },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" PLUGIN SETUP
" nvim-colorizer.lua setup. creates an autocmd for all file types.
" lua require'colorizer'.setup()
let g:sneak#s_next = 1 "sneak use s/S to jump forward/backward
let g:shfmt_opt="-ci" "neoformat
let g:neoformat_enabled_python = ['black', 'autopep8', 'yapf', 'docformatter']
let g:neoformat_only_msg_on_error = 1
" Vim Rooter
let g:rooter_silent_chdir = 1 "don't echo project directory
" list of string which identify root dirs
let g:rooter_patterns = ['.git']
" root hast direct parent dir 'Projects'
" let g:rooter_patterns = ['Projects']

" Vim Surround
" replace: cs"'
" remove:  ds"
" create:  ysiw"
" wrap entire line: yss"

" Open hotkeys
"map <C-p> :Files<CR>
" nmap <leader>; :Buffers<CR>

" nnn
lua << EOF
require("nnn").setup()
EOF





" GENERAL
set nocompatible "drop some legacy compatibility in favour of new things
filetype indent on
filetype on "file specific goodness
filetype plugin on
set autoread "refresh file contents when modified externally
set colorcolumn=80 "visual ruler
set cursorline "highlight the screen line of the cursor
set encoding=utf-8 "character encoding to be used in Vim
set fileencoding=utf-8 "character encoding to be used by current file
set gdefault "use the 'g' (global) flag for :substitute by default
" set listchars=tab:▸\ ,eol:¬,nbsp:⋅,trail:⋅ "representation of non-vis chars
set listchars=extends:»,precedes:«,tab:▸\ ,nbsp:⋅,trail:⋅ "representation of non-vis chars
set list "show non-vis characters
set number "show line numbers
set numberwidth=4
set incsearch "incremental search
set ignorecase "search case insensitive
set smartcase "search case sensitive when a capital letter is entered
set signcolumn=yes "always show sign column
set shell=/bin/bash "default shell
set showmatch "when inserting a bracket, briefly jump to its match
set wildmode=list:longest "activate <TAB> auto-completion for file paths
set winheight=5 "min number of lines for current window
set winminheight=5 "min number of lines for any window
set winwidth=84 "min number of columns used for the current window
set splitright "vsplit will split window to the right
set splitbelow "split will split window below the current one
set cmdheight=2 "height of cmd height to show hints/errors
set updatetime=300 "time of no cursor movment to trigger CursorHold
set undodir=~/.vimdid "permanent undo
set undofile
" set scrolloff=2 "minimal number of lines to keep above/below the cursor
set laststatus=2 "always show the status line
set clipboard+=unnamedplus "use system clipboard
set timeoutlen=300 "time in ms to wait for a mapped sequence to complete
set mouse=a "use mouse scrolling for vim instead tmux terminal



" TEXT, TABS AND INDENTS
set expandtab "expand <Tab> to spaces in Insert mode
set tabstop=4 "number of spaces a <Tab> in the text stands for
set softtabstop=4 "number of spaces to insert for a <Tab>
set shiftwidth=4 "number of spaces used for each step of (auto)indent
set autoindent "automatically set the indent of a new line
set smartindent "do clever autoindenting
set wrap "wrap long lines
set linebreak "don't break in the middle of words

" set smarttab

" WRAPPING OPTIONS
set formatoptions=tc "wrap text and comments using textwidth
set formatoptions+=r "continue comments when pressing ENTER in I mode
set formatoptions+=q "enable formatting of comments with gq
set formatoptions+=n "detect lists for formatting
set formatoptions+=b "auto-wrap in insert mode, and do not wrap old long lines

" FILES, BACKUPS AND UNDOS
set noswapfile "don't use a swap file for this buffer
set nobackup "don't write a backup file before overwriting a file
set nowb "don't write a backup file before overwriting a file

" THEME AND COLORS
let base16colorspace=256
set background=dark
set termguicolors
syntax enable
" colorscheme base16-atelier-dune
" colorscheme base16-atelier-dune-light
colorscheme base16-woodland


" EXPLICIT FILE TYPING
au BufNewFile,BufRead *.adoc set filetype=asciidoc
autocmd BufRead *.tex set filetype=tex

" KEYBOARD MAPPINGS
inoremap jk <ESC>
" stop search highlighting
nnoremap <C-h> :nohlsearch<CR>
vnoremap <C-h> :nohlsearch<CR>
" quick save
nmap <leader>w :w<CR>
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Y copies everything from cursor to end of line
noremap Y y$
" Jump to start and end of line using the home row keys
map H ^
map L $
" Keep the blog selected when moving right or left
vmap < <gv
vmap > >g
" Format file
noremap <leader>f :Neoformat<CR>
" Search results centered please
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz
" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
" nnoremap <silent> g* g*zz
" goto definition in new vertical split window
map gdv <C-w>vgd
" goto definition in new horizontal split window
map gdh <C-w>sgd
" elevated save
cmap w!! w !sudo tee %
" insert timestamp
nmap <leader>d i<C-R>=strftime("%Y-%m-%d %H:%M:%S+11:00")<CR><Esc>
imap <leader><leader>d <C-R>=strftime("%Y-%m-%d %H:%M:%S+11:00")<CR>
" Reload nvim config
map <leader>r :source $MYVIMRC<CR>
" search for highlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
map <leader>md :set ft=markdown<CR>


" AUTOCMDS
" vim-commentary: add new comment string for file type
" autocmd FileType apache setlocal commentstring=#\ %s


" lightline
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction
let g:lightline = {
     \  'colorscheme': 'one',
     \  'active': {
     \    'left': [ [ 'mode', 'paste' ],
     \              [ 'readonly', 'filename', 'modified' ] ],
     \    'right': [ [ 'lineinfo' ],
     \              [ 'percent' ],
     \              [ 'fileencoding', 'filetype' ] ]
     \  },
     \  'component_function': {
     \    'filename': 'LightlineFilename',
     \  },
     \}


tnoremap <C-A-n> <cmd>NnnExplorer<CR>
nnoremap <C-A-n> <cmd>NnnExplorer %:p:h<CR>
tnoremap <C-A-p> <cmd>NnnPicker<CR>
nnoremap <C-A-p> <cmd>NnnPicker<CR>


" NERDTree
" map <C-n> :NERDTreeToggle<CR>
" map <C-f> :NERDTreeFocus<CR>
" let NERDTreeShowHidden=1

" NERTCommenter
" press: 78GV88G <leader>c<space> -> comment lines 78-88
" let g:NERDSpaceDelims = 1
" let g:NERDTrimTrailingWhitespace = 1
" let g:NERTCommentEmptyLines = 1
" let g:NERDDefaultAlign = 'left'
" let g:NERDCompactSexyComs = 1


" Switch windows quickly with CTRL+{h,j,k,l}
" This br:aks backspace in a terminal, but I never use backspace in
" normal mode
" map <C-h> <C-W>h
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-l> <C-W>l









" Shortcuts for fzf, Ag ...
 map <C-p> :FZF<CR>
" map <leader>a :Ag<CR>
" See https://github.com/BurntSushi/ripgrep
"map <leader>h :History
"map <leader>l :Lines<CR>

" Remember cursor position between vim sessions
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
" Center buffer around cursor when opening files
autocmd BufRead * normal zz

" no wrap and no colorcolumn for .log files
autocmd FileType log
                \   set colorcolumn=0 |
                \   set nowrap

" set filetype iptables. plugin needed
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



""""" Programming Lanuages """""
" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
au Filetype rust set colorcolumn=100

" ### Python
" Auto format on write
autocmd BufWritePre *.py execute ':Black'



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


" terminal mode
tnoremap <Esc> <C-\><C-n>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

" move line by line with wrap=on but do the jump x lines correctly
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" insert mapping
inoremap ;mfg Mit freundlichen gruessen<cr>/Max

" turn off relativenumber for insert mode
" augroup every
"   autocmd!
"   au InsertEnter * set norelativenumber
"   au InsertLeave * set relativenumber
" augroup END

augroup md
  autocmd!
  au BufNewFile,BufRead *.md syntax keyword todo TODO
  au BufNewFile,BufRead *.md inoremap <buffer> ;` ```<cr>```<Up>
augroup END

" func URL_Decode()
"    sub/%2C/,/ge
"    sub/%3A/:/ge
"    sub/%5B/[/ge
"    sub/%5D/]/ge
" endfunc
" TODO: create different mapping as this interferes with standard vim
" movements.
" nmap c :call URL_Decode()<CR>


" let's see if auto format annoys me at some point
"augroup fmt
  "autocmd!
  "autocmd BufWritePre * undojoin | Neoformat
"augroup END


" Find files using Telescope command-line sugar.
" e.g. manual call:
" :Telescope git_commits
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby
