vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- setup plugin manager if not there yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {}
require('lazy').setup({
    --    'vimwiki/vimwiki',
    'neovim/nvim-lspconfig',    -- Configurations for Nvim LSP
    'hrsh7th/nvim-cmp',         -- Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
    'hrsh7th/cmp-path',         -- file path completion
    -- 'hrsh7th/cmp-nvim-lsp-signature-help',  -- no docs on github. always shows function docs which is not what I want.
    'ray-x/lsp_signature.nvim', -- show function signature. do not show docs
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip',         -- Snippets plugin
    'tpope/vim-sleuth',         -- automatic indent detection
    'tpope/vim-commentary',
    'nvim-tree/nvim-tree.lua',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    'tpope/vim-fugitive',          -- provide :Git
    'mhinz/vim-signify',           -- show git changes in sign column
    -- 'lewis6991/gitsigns.nvim' -- not used yet but looks good
    'LnL7/vim-nix',                -- nix syntax
    'rust-lang/rust.vim',
    'norcalli/nvim-colorizer.lua', -- blazing fast colorizer
    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^6', -- Recommended
    --     lazy = false, -- This plugin is already lazy
    -- },
    -- 'ThePrimeagen/harpoon'
    'othree/html5.vim',        -- svelte dev
    'pangloss/vim-javascript', -- svelte dev
    'evanleck/vim-svelte',     -- svelte dev
    -- Writing
    'folke/zen-mode.nvim',
    'junegunn/limelight.vim',
    'preservim/vim-pencil',
    --    'tpope/vim-markdown',
    -- markdown
    {
        'plasticboy/vim-markdown',
        ft = { "markdown" },
        dependencies = {
            'godlygeek/tabular',
        },
        config = function()
            -- never ever fold!
            vim.g.vim_markdown_folding_disabled = 1
            -- support front-matter in .md files
            vim.g.vim_markdown_frontmatter = 1
            -- 'o' on a list item should insert at same level
            vim.g.vim_markdown_new_list_item_indent = 0
            -- don't add bullets when wrapping:
            -- https://github.com/preservim/vim-markdown/issues/232
            vim.g.vim_markdown_auto_insert_bullets = 0
        end
    },
    'dag/vim-fish',

    'nvim-lualine/lualine.nvim', -- status bar
    -- colorschemes
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = {
            italic = {
                strings = false,
                comments = false,
                operators = false,
                folds = true,
            },
            contrast = "hard", -- "hard", "soft", or ""
        }
    },
    'savq/melange-nvim',
    'p00f/alabaster.nvim', -- minimal color theme
    -- 'folke/tokyonight.nvim',
    -- 'chriskempson/base16-vim',
    -- 'catppuccin/nvim',
    -- 'sainnhe/sonokai',
    -- 'rafi/awesome-vim-colorschemes'
    -- {
    --     "vague2k/vague.nvim",
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all
    -- },
    -- 'https://git.sr.ht/~romainl/vim-bruin'
    -- 'davidosomething/vim-colors-meh'
    --
    --
    -- 'freitass/todo.txt-vim'  -- also see extended fork of above project at
    -- https://gitlab.com/dbeniamine/todo.txt-vim
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    },

    -- formatter
    --   'stevearc/conform.nvim',
    --  opts = {},
    --
    -- 'karb94/neoscroll.nvim'
    'justinmk/vim-sneak', -- jump to place by typing two letters
    'tpope/vim-surround', -- surround all the things
    -- 'marcelofern/vale.nvim', -- vale prose linter
    'junegunn/fzf',
    'junegunn/fzf.vim', -- fzf integration
    -- {
    -- "nvimtools/none-ls.nvim", -- TODO what is that again?
    -- dependencies = {
    --   "nvimtools/none-ls-extras.nvim",
    -- },

    -- {
    --     "folke/trouble.nvim", -- TODO what is that again?
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     },
    -- }
    {
        "lervag/vimtex",
        -- lazy = false,     -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end
    },
    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',
        opts = {},    -- lazy.nvim will implicitly calls `setup {}`
    },
    {
        "amitds1997/remote-nvim.nvim",
        version = "*",                       -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim",         -- For standard functions
            "MunifTanjim/nui.nvim",          -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = true,
    },
    -- awesome plugin to center the current buffer window
    { "shortcuts/no-neck-pain.nvim", version = "*" },
    {
        'notjedi/nvim-rooter.lua',
        config = function()
            require('nvim-rooter').setup()
        end
    },
}, lazy_opts)

-- nvim-tree lua setup
-- Disable builtin netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()
-- require("nvim-tree").setup({
--   sort = {
--     sorter = "case_sensitive",
--   },
--   view = {
--     width = 30,
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })



local luasnip = require 'luasnip'
local cmp = require 'cmp'

cmp.setup {
    completion = {
        keyword_length = 2, -- number of chars needed to trigger auto completion
    },
    -- preselect = cmp.PreselectMode.None, -- disable preselection of first item
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- false: don't autoselect first entry
    }),
    sources = {
        { name = 'nvim_lsp' },
        -- { name = 'luasnip' },
        { name = 'path' },
    },
    experimental = {
        ghost_text = true,
    },
}

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    })
})

-- vim.lsp.config['ltex'] = {
--     settings = {
--         ltex = {
--             -- language = "en-US",
--             -- language = "de-DE",
--         }
--     }
-- }

vim.lsp.config['texlab'] = {
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
                ['local'] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 80,
        },
    },
}

vim.lsp.enable({
    -- "ltex",
    "lua_ls",
    "rust_analyzer",
    "texlab",
    "gopls",
    "pyright",
    "ccls",
    "bashls",
    "typst",
    "tinymist",
    "marksman",
})


vim.diagnostic.config({
    virtual_text = { current_line = true }
})

vim.g.rustfmt_autosave = 1

require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "diff", "vim", "vimdoc", "python", "markdown" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = false, -- NOTE enable treesitter highlight
        additional_vim_regex_highlighting = true,
    },
}

-- pencil settings
-- pencil init has issues. only detects the textwidth in the second init run.
vim.cmd([[let g:pencil#textwidth = 72]])
-- zen mode
require('zen-mode').setup({
    window = {
        backdrop = 0.90,
        width = 90,
    },
    plugins = {
        tmux = {
            enabled = true
        },
        alacritty = {
            enabled = true,
            font = "14",
        },
    },
    on_open = function(win)
        -- vim.o.colorcolumn = 0
        vim.opt.formatoptions:append('a')
        local cmd = "alacritty msg config -w %s 'font.normal = { family=\"Hermit\" }'"
        local alacritty_win_id = vim.fn.expand("$ALACRITTY_WINDOW_ID")
        -- vim.fn.system(cmd:format(alacritty_win_id))
        vim.cmd("Limelight")
    end,
    on_close = function()
        vim.opt.formatoptions:remove('a')
        vim.cmd("Limelight!")
    end,
})

require('telescope').setup {
    defaults = {
        -- :help telescope.layout.vertical
        layout_strategy = 'vertical',
        layout_config = {
            height = 0.95,
            width = 0.95,
            mirror = true, -- nice on large vertical monitors
            preview_height = 0.7,
        },
    },
}

vim.keymap.set('n', '<leader>f', ":NoNeckPain<cr>", {})
-- fzf mappings
vim.keymap.set('n', '<c-p>', ":Files<cr>", {})
-- vim.keymap.set('n', '<leader>o', ":Files<cr>", {})
vim.keymap.set('n', '<leader>o', ":NvimTreeToggle<cr>", {})
vim.keymap.set('n', '<leader>g', ":Rg<cr>", {})
vim.keymap.set('n', '<leader>b', ":Buffers<cr>", {})

local tele = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>f', tele.find_files, {})
-- TOOD: hidden filesvim.keymap.set('n', '<leader>hf', tele.find_files, {})
-- vim.keymap.set('n', '<leader>gf', tele.git_files, {})
-- vim.keymap.set('n', '<leader>g', tele.live_grep, {})
-- vim.keymap.set('n', '<leader>b', tele.buffers, {})
vim.keymap.set('n', '<leader>bg', tele.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>?', tele.help_tags, {})
vim.keymap.set('n', '<leader>S', tele.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>s', tele.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>bs', tele.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>d', tele.diagnostics)
vim.keymap.set('n', '<leader>h', tele.spell_suggest)
vim.keymap.set('n', '<leader>tl', [[:s/\<\w/\u&/g<CR>:nohlsearch<CR>]])

require('colorizer').setup {
    'css',
    'javascript',
    'html',
}

require('lualine').setup {
    options = {
        icons_enabled = false,
        -- theme = 'onedark',
        -- theme = 'gruvbox',
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1, -- relative path to project root
            }
        },
    },
}


-- Calling vim functions in lua. both do the same thing
-- vim.fn['fzf#vim#files']('~/projects', false)
-- vim.call('fzf#vim#files', '~/projects', false)

-- print(vim.inspect(vim.opt.autoindent)) : inspect a table/object
-- vim.env : environment settings
-- vim.g   : global variables
-- vim.o.  : general options
-- vim.bo. : buffer scoped options
-- vim.wo  : window scoped options
-- vim.opt : set global, window, and buffer options
local o = vim.opt
o.shell = '/usr/bin/env bash'
o.shortmess:append('I') -- no welcome message
--o.smarttab = false
o.number = true
o.numberwidth = 4
o.relativenumber = true
o.cursorline = true
o.signcolumn = 'yes'
o.ignorecase = true
o.smartcase = true
o.wrapscan = false -- in search, do not wrap around file end.
-- not working yet
-- o.winminheight = 2 -- min number of lines for any window
-- o.winheight = 2  -- min number of lines for current window
-- o.winwidth = 84 -- min number of columns used for the current window
-- o.undodir = '~/.vimdid' -- use vim.fn.expand('~'); default: ~/.local/data/nvim/undo
o.undofile = true   -- keep undo history for files
o.scrolloff = 2     -- mininum lines above/below the cursor
o.laststatus = 2    -- always show status line
o.mouse:append('a') -- use mouse scrooling in nvim instead tmux
o.splitright = true
o.splitbelow = true
o.swapfile = false
o.formatoptions:append('np') -- :help fo-table
o.linebreak = true           -- do not break in the middle of words
o.breakindent = true
o.breakindentopt = "shift:2"
-- o.showbreak='»'
o.list = true -- show invisible characters defined below
o.listchars = { tab = '▸ ', trail = '·' }
-- o.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

o.timeoutlen = 300
o.updatetime = 100 -- frequent signify updates (git)
-- o.showmatch = true -- show matching brackets
o.foldenable = true
o.foldlevel = 99
-- o.autoindent = false
o.spelllang = 'en,de'
o.completeopt = 'menuone,noinsert,noselect'
o.wildignore = { '*.o', '*.obj.', '*.lock' } -- ignore in file/path completion
-- explicitly set tab settings and shiftwidth settings
o.expandtab = false
o.shiftwidth = 4
o.tabstop = 4
o.conceallevel = 0
o.winborder = 'rounded'
-- b: only auto wrap if I started insert mode before textwidth was reached
-- backup of files (:backup) is off by default but when overwriting a file a
-- backup is made (turn off :nowritebackup)
-- set wildmode=list:longest "activate <TAB> auto-completion for file paths
-- set wildmode=longest,list
-- set nofoldenable
-- set wildoptions=pum -- make options popup transparent
-- set pumblend=20
-- set winblend=30 -- also something with transparency

-- vim.cmd.colorscheme("melange")
vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme("retrobox")
-- vim.cmd.colorscheme("alabaster")
-- vim.cmd.colorscheme("wildcharm")
-- vim.cmd.colorscheme("vague")

vim.cmd([[
hi link jsonCommentError Comment
]])


-- User contributed tips for neovim LSP
-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips
local function preview_location_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    -- group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- disable the semantic tokens by lsp; it messes up syntax highlighting.
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gp', PeekDefinition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr><cmd>wa', opts)
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>fo', function()
            vim.lsp.buf.format { async = true }
        end, opts)

        vim.keymap.set('n', '<leader><cr>', '<cmd>LspTexlabForward<cr>', opts)

        -- Get signatures (and _only_ signatures) when in argument lists.
        -- either this or cmp-nvim-lsp-signature-help in cmp sources
        require "lsp_signature".on_attach({
            doc_lines = 0,
            handler_opts = {
                border = "none"
            },
        })
    end,
})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- for recursive bindings set `remap=true` for actions created by plugins, for example.
-- vim.keymap.set('n', '<leader>e', '%', {remap = true, desc = 'Go to matching pair'})
--  show a mapping with:  :map *
vim.keymap.set('i', 'jk', '<esc><right>')
vim.keymap.set('i', ';w', '<esc>:w<cr>')
vim.keymap.set('n', '<c-h>', ':nohlsearch<cr>')
vim.keymap.set('v', '<', '<gv')                                         -- keep block selected when shifting
vim.keymap.set('v', '>', '>gv')                                         -- keep block selected when shifting
vim.keymap.set('n', 'n', 'nzz')                                         -- center search results
vim.keymap.set('n', 'N', 'Nzz')                                         -- center search results
-- vim.keymap.set('n', '*', '*zz')                                      -- center search results
vim.keymap.set('n', '#', '#zz')                                         -- center search results
vim.keymap.set('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])        -- search for selected text
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv")                            -- move highlighted text around
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv")                            -- move highlighted text around
vim.keymap.set('n', 'J', 'mzJ`z')                                       -- cursor stays in place when merging lines
vim.keymap.set('', 'gdv', ':vsplit | lua vim.lsp.buf.definition()<cr>') -- goto definition. vsplit
vim.keymap.set('', 'gds', ':split | lua vim.lsp.buf.definition()<cr>')  -- goto definition. hsplit
vim.keymap.set('n', '<C-d>', '<C-d>zz')                                 -- center cursor when moving down
vim.keymap.set('n', '<C-u>', '<C-u>zz')                                 -- center cursor when moving up
vim.keymap.set('n', '<C-j>', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<cr>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lnext<cr>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<cr>zz')
vim.keymap.set('', 'C-p', 'FZF<cr>')        -- no fzf integration yet TODO
-- vim.keymap.set('c', 'w!!', 'w !sudo tee %') -- does not work currently TODO
vim.keymap.set('t', '<esc>', '<C-\\><C-n>') -- goto normal mode in :terminal
vim.keymap.set('n', '<leader>r', ':source $MYVIMRC<cr>:echo "nvim config reloaded"<cr>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>q', ':q<cr>')
vim.keymap.set('n', '<leader>x', ':x<cr>')
vim.keymap.set('n', '<leader><leader>', '<c-^>')
vim.keymap.set('n', '<leader>ee', [[:e <C-R>=expand("%:p:h") . "/" <CR>]]) -- open file adjacent to current file
vim.keymap.set('n', '<leader>p', '"*P<cr>')                                -- paste from system clipboard
vim.keymap.set('v', '<leader>y', '"+y')                                    -- copy highlight to system clipboard
vim.keymap.set('n', '<leader>Y', 'ggVG"+y<C-o>')                           -- copy buffer to system clipboard
vim.keymap.set('n', 'H', '^')                                              -- move to first char in line
vim.keymap.set('n', 'L', '$')                                              -- move to last char in line
-- vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<cr>')
vim.keymap.set('n', '<leader>t', ':set autoindent noexpandtab tabstop=4 shiftwidth=4<cr>')
vim.keymap.set('n', '<leader>T', ':set autoindent expandtab tabstop=4 shiftwidth=4<cr>')
vim.keymap.set('n', '*', ':keepjumps normal! mi*`i<CR>') -- do not jump directly to next match
vim.keymap.set('n', '<C-m>', ':Man<cr>')
-- vim.keymap.set('n', '<leader>l', [["ayiw<cmd>!lookup -f en -t de <C-R><cr>]])
-- vim.keymap.set('v', ',q', [[:<C-u>execute "normal! \"ay:!~/.local/bin/translate.sh " . shellescape(@a)<cr>]])

vim.keymap.set('n', '<leader>c', function()
    if vim.o.conceallevel == 2 then
        vim.o.conceallevel = 0
    else
        vim.o.conceallevel = 2
    end
end)

-- vim.keymap.set('n', 'M', [[:Man \V<C-R>=escape(@",'/\')<cr>]])
-- dfeault K mapping:   :m '<-2<CR>gv=gv

-- tell vim-commentary how to comment in json
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'json',
    command = [[setlocal commentstring=//\ %s]],
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank { timeout = 400 }
    end,
})

-- highlight TO'DO in markdown files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = '*.md',
    -- does not work?
    command = [[
syntax keyword todo TODO
]]
})

-- Add shortcut to insert code block in markdown
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = '*.md',
    command = [[
inoremap <buffer> ;c ```<cr>```<Up>
inoremap <buffer> ;q <div class="quote"><cr><cr></div><Up>
TSBufEnable highlight
]]
})

-- remove trailing whitespace on save, except in mail
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = '*',
    callback = function()
        if vim.bo.filetype ~= "mail" and vim.bo.filetype ~= "markdown" then
            vim.cmd("mark w")
            vim.cmd("%s/\\s\\+$//e")
            vim.cmd("'w")
        end
    end
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = '*.py',
    callback = function()
        vim.cmd("silent !black --quiet %")
    end
})


-- vim -b : edit binary using xxd-format
vim.cmd([[
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
]])

-- move line by line with wrap=on but do the jump x lines correctly
vim.cmd([[
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
]])

-- Underline some text with '-' or '=' (e.g. in markdown)
for _, symbol in pairs({ '-', '=' }) do
    vim.keymap.set('n', '<leader>' .. symbol, function()
        local len = #vim.api.nvim_get_current_line()
        local underline = string.rep(symbol, len)
        vim.api.nvim_put({ underline }, "l", true, true)
    end)
end

-- datetime format: 2023-09-06T13:17+02:00
--vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
-- vim.api.nvim_create_autocmd("VimEnter", {
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    -- pattern = '*',
    command = [[
inoremap <buffer> ;d <C-R>=strftime('%Y.%m.%d')<CR>
inoremap <buffer> ;D <C-R>=strftime('%Y-%m-%d')<CR>
inoremap <buffer> ;dt <C-R>=strftime('%a %F %T%z')<CR>
inoremap <buffer> ;md &mdash;
inoremap <buffer> ;nd &ndash;
inoremap <buffer> ;rev Reviewed-By: Max
inoremap <buffer> ;mfg Mit freundlichen Grüßen,
inoremap <buffer> ;g — Max
inoremap <buffer> ;sho ¯\_(ツ)_/¯
]]
})

-- Meta data for pandoc pdf generation with eisvogel template
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = '*.md',
    command = [[
inoremap <buffer> ;eis ---\
title: TITLE\
titlepage: true\
author: \
date: <C-R>=strftime('%Y-%m-%d')<CR>\
colorlinks: true\
listings-no-page-break: true\
code-block-font-size: \footnotesize\
#listings-disable-line-numbers: false\
#toc: true\
#toc-own-page: true\
---\

]]
})

vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
    pattern = os.getenv("HOME") .. "/notes/*",
    callback = function()
        -- add auto formatting
        vim.cmd("setlocal fo+=w")
    end
})

-- when writing an email, skip the mail headers (first blank line)
-- and go to insert mode
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*neomutt-*',
    callback = function()
        vim.api.nvim_command([[/^\n]])
        vim.api.nvim_command("normal o")
        vim.api.nvim_command("startinsert!")
    end
})

-- TODO still a good value? what's the difference to patience?
vim.cmd([[set diffopt+=algorithm:histogram]])
-- set diffopt+=indent-heuristic

-- add closing html tag by pressing  ,/
vim.cmd([[imap ,/ </<C-X><C-O>]])

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = "todo*.txt",
    callback = function()
        -- if vim.api.nvim_buf_get_name(0) == vim.fn.expand("~/nc/todo.txt") then
        vim.cmd([[syntax match TODO /TODO/]])
        vim.api.nvim_set_hl(0, "TODO", { bg = "khaki", fg = "black" })
        vim.cmd([[syntax match wait /WAIT/]])
        vim.api.nvim_set_hl(0, "wait", { bg = "pink", fg = "black" })
        -- end
    end
})

-- Zotero integration
vim.cmd([[
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  " let format = &filetype =~ '.*tex' ? 'citep' : 'pandoc'
  let format = 'citep'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>
]])
