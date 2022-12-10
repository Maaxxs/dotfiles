let mapleader = ","

call plug#begin()
" VIM enhancments
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
" extend vim % key to language specific words
" Plug 'andymass/vim-matchup'
" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" smart commenter
Plug 'tpope/vim-commentary'
" maybe use automatic indent detection based on heuristics too
Plug 'tpope/vim-sleuth'

" required for telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'luukvbaal/nnn.nvim'
" Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/nerdcommenter'

" Git support
Plug 'tpope/vim-fugitive' " provides :Git
Plug 'mhinz/vim-signify' " use signcolum

Plug 'itchyny/lightline.vim'

" Fuzzy search
Plug 'airblade/vim-rooter'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug '/usr/bin/fzf'
" Plug 'junegunn/fzf.vim'
" use system binary for fzf
" Plug 'junegunn/fzf'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

Plug 'dag/vim-fish'
" Semantic language support
Plug 'neovim/nvim-lspconfig'
" autocompletion
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
" filesystem path completion
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
" buffer completion
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets, so we use cmp-vsnip and vim-snip
" but do not load it as source
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" maybe that too:
"cmp cmdline completion
" Plug 'hrsh7th/cmp-cmdline'
" extra functionality over rust analyzer
" Plug 'simrat39/rust-tools.nvim'

" Syntactic Language support
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

" Markdown
Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
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

Plug 'sbdchd/neoformat'
" colorize color names and hex values
" Plug 'norcalli/nvim-colorizer.lua'
"base16 color themes
Plug 'chriskempson/base16-vim'

" iptables highlighting
" Plug 'vim-scripts/iptables'
call plug#end()


" ==============================================================================
" PLUGIN SETUP
" ==============================================================================
" sneak: use s/S to jump forward/backward
let g:sneak#s_next = 1
" neoformat
let g:shfmt_opt='-ci'
let g:neoformat_enabled_python = ['black', 'autopep8', 'yapf', 'docformatter']
let g:neoformat_only_msg_on_error = 1

" color to highlight extra whitespace
let g:better_whitespace_guicolor='green'
let g:better_whitespace_enabled=0
autocmd FileType markdown EnableWhitespace

" let g:vim_markdown_new_list_item_indent = 0
" let g:vim_markdown_auto_insert_bullets = 0
" let g:vim_markdown_frontmatter = 1

" Vim Rooter
"do not echo project directory
let g:rooter_silent_chdir = 1
" list of string which identify root dirs
let g:rooter_patterns = ['.git']
" root hast direct parent dir 'Projects'
" let g:rooter_patterns = ['dev']

" Vim Surround
" replace: cs"'
" remove:  ds"
" create:  ysiw"
" wrap entire line: yss"

" Open hotkeys
"map <C-p> :Files<CR>
" nmap <leader>; :Buffers<CR>

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" GENERAL
set nocompatible "drop some legacy compatibility in favour of new things
set shortmess+=I " disable startup message
filetype indent on
filetype on "file specific goodness
filetype plugin on
set autoread "refresh file contents when modified externally
"set colorcolumn=80 "visual ruler
"set cursorline "highlight the screen line of the cursor
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
"set showmatch "when inserting a bracket, briefly jump to its match
set wildmode=list:longest "activate <TAB> auto-completion for file paths
set winheight=5 "min number of lines for current window
set winminheight=5 "min number of lines for any window
set winwidth=84 "min number of columns used for the current window
set splitright "vsplit will split window to the right
set splitbelow "split will split window below the current one
set cmdheight=2 "height of cmd height to show hints/errors
set updatetime=500 "time of no cursor movment to trigger CursorHold
set undodir=~/.vimdid "permanent undo
set undofile
" set scrolloff=2 "minimal number of lines to keep above/below the cursor
set laststatus=2 "always show the status line
" set clipboard+=unnamedplus "use system clipboard
set timeoutlen=300 "time in ms to wait for a mapped sequence to complete
set mouse=a "use mouse scrolling for vim instead tmux terminal
set wildmode=longest,list


" TEXT, TABS AND INDENTS
set autoindent "automatically set the indent of a new line
set smartindent "do clever autoindenting
set wrap "wrap long lines
set linebreak "do not break in the middle of words

" set smarttab

" WRAPPING OPTIONS
set formatoptions=tc "wrap text and comments using textwidth
set formatoptions+=r "continue comments when pressing ENTER in I mode
set formatoptions+=q "enable formatting of comments with gq
set formatoptions+=n "detect lists for formatting
set formatoptions+=b "auto-wrap in insert mode, and do not wrap old long lines

" FILES, BACKUPS AND UNDOS
set noswapfile "do not use a swap file for this buffer
set nobackup " do not write a backup file before overwriting a file
set nowb "do not write a backup file before overwriting a file

" THEME AND COLORS
let base16colorspace=256
set background=dark
set termguicolors
syntax enable
"colorscheme base16-atelier-dune
" colorscheme base16-atelier-dune-light
"colorscheme base16-woodland
"colorscheme base16-irblack

" jonhoo color configuration
colorscheme base16-gruvbox-dark-hard
" Customize the highlight a bit.
" Make comments more prominent -- they are important.
call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
" Make it clearly visible which argument we are at.
call Base16hi("LspSignatureActiveParameter", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold", "")

" ==============================================================================
" KEYBOARD MAPPINGS
" ==============================================================================
inoremap jk <ESC>
" stop search highlighting
nnoremap <C-n> :nohlsearch<CR>
vnoremap <C-n> :nohlsearch<CR>
" quick save
nmap <leader>w :w<CR>
" quit
nmap <leader>q :q<CR>
" force quit
nmap <leader>qq :q!<CR>
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Y copies everything from cursor to end of line
noremap Y y$
" Jump to start and end of line using the home row keys
" map H ^
" map L $
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

" vim, please recognize comments in json
autocmd FileType json syntax match Comment +\/\/.\+$+
" tell vim-commentary how to comment in json
autocmd FileType json setlocal commentstring=//\ %s

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


" Switch windows quickly with CTRL+{h,j,k,l}
" This br:aks backspace in a terminal, but I never use backspace in
" normal mode
" map <C-h> <C-W>h
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-l> <C-W>l



" Remember cursor position between vim sessions
autocmd BufReadPost *
    \ if expand('%:p') !~# '\m/\.git/' && line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

" Center buffer around cursor when opening files
autocmd BufRead * normal zz

" no wrap and no colorcolumn for .log files
autocmd FileType log
                \   set colorcolumn=0 |
                \   set nowrap



""""" Programming Lanuages """""
" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'wlcopy'
au Filetype rust set colorcolumn=100


" ### Python
" Auto format on write
" TODO: call Neoformat?
" autocmd BufWritePre *.py execute ':Black'

" Javascript
let javaScript_fold=0

" Java
let java_ignore_javadoc=1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

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

augroup md
  autocmd!
  au BufNewFile,BufRead *.md syntax keyword todo TODO
  au BufNewFile,BufRead *.md inoremap <buffer> ;` ```<cr>```<Up>
augroup END

func URL_Decode()
   sub/%2C/,/ge
   sub/%3A/:/ge
   sub/%5B/[/ge
   sub/%5D/]/ge
endfunc
" nmap c :call URL_Decode()<CR>

" let's see if auto format annoys me at some point
"augroup fmt
  "autocmd!
  "autocmd BufWritePre * undojoin | Neoformat
"augroup END


" when telescope find_files does not show hidden files, either use
" <leader>fff which will include .the .git dir or use C-p below
map <C-p> :FZF<CR>

" use 'git ls-files' as source for fzf. in terminal: git ls-files | fzf 
" to map: call fzf#run({'source': 'git ls-files', 'sink': 'e'})

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif


" does not work yet
" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)



" Find files using Telescope command-line sugar.
" e.g. manual call:
" :Telescope git_commits
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" how it look with lua require:
" nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>


" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby


" TODO: maybe at some point.
" Very magic by default
" nnoremap ? ?\v
" nnoremap / /\v
" cnoremap %s/ %sm/

" if only one window in vim on big screen, ~center it.
nnoremap <leader>co :aboveleft vnew +vertical\ resize\ 85<CR><C-W>l
nnoremap <leader>cc <C-W>h:q!<CR>

au TextYankPost * silent! lua vim.highlight.on_yank { timeout=300 }


" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif


" Move to the end as if messes up syntax highlighting for vim
" see: https://stackoverflow.com/questions/74448018/neovim-broken-syntax-highlighting-after-heredoc-lua-eof-in-vimscript
" LSP configuration
lua << END
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
--  window = {
--    completion = cmp.config.window.bordered(),
--    documentation = cmp.config.window.bordered(),
--  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    -- maybe change abvoe to <CR>
  }),
  sources = cmp.config.sources({
    -- order specifies priority
    { name = 'nvim_lsp' },
    --  { name = 'vsnip' }, -- For vsnip users.
    { name = 'path' },
  }, {
    --  { name = 'buffer' },
  }),
--  experimental = {
--    ghost_text = true,
--  },
})


local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- TODO: formatting is done by Neoformat.
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<leader>t', '<cmd>Telescope diagnostics<cr>', {buffer=0})

  -- Get signatures (and _only_ signatures) when in argument lists.
  require("lsp_signature").on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

-- Set up lspconfig with new capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())



-- for every language server, do
-- require('lspconfig').<LS>.setup{}
require('lspconfig').pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities
}
require('lspconfig').rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
-- documentation: https://github.com/fannheyward/coc-rust-analyzer/blob/master/README.md#configurations
-- inlay hints: rust-analyzer.inlayHints.enable
-- postfix enable: rust-analyzer.completion.postfix.enable
-- rust-analyzer.inlayHints.closureReturnTypeHints.enable
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
         completion = {
-- l = var.len().ok() <- postfix snippet which will wrap expression in Ok() -> Ok(var.len())
           postfix = {
             enable = false,
           },
         },
         inlayHints = {
            enable = false,
            closureReturnTypeHints = true;
         }
       }
    }
}

require('lspconfig').ccls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}


-- TODO: check what this is doing
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )

require("nnn").setup()
END

