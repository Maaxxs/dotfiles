--------------------------
-- NeoVim Configuration --
--------------------------

--------------------
-- Global Options --
--------------------
-- for vim script `let` mappings use vim.g
vim.g.mapleader = ' '
-- vim.g.base16colorspace = 256 -- not sure if I need/want this

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- packer manages itself
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp-signature-help' -- signature help
    -- use 'hrsh7th/cmp-path' -- file path completion
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'tpope/vim-sleuth' -- automatic indent detection
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'tpope/vim-fugitive' -- provide :Git
    use 'mhinz/vim-signify' -- show git changes in sign column
    use 'LnL7/vim-nix' -- nix syntax
    use 'simrat39/rust-tools.nvim' -- expands and inits rust-analyzer
    use {
        'ldelossa/gh.nvim',
        requires = { { 'ldelossa/litee.nvim' } }
  }
end)


-- Luasnip
local luasnip = require 'luasnip'
-- autocompletion setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
  },
}

----------------------------
-- Setup Language Servers --
----------------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require('lspconfig')
local capas = require('cmp_nvim_lsp').default_capabilities()
-- Python
lspconfig.pylsp.setup {
    capabilities = capas,
}

-- Lua
lspconfig.lua_ls.setup {
    capabilities = capas,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- Rust analyzer setup through rust-tools
-- https://github.com/simrat39/rust-tools.nvim/#configuration
local rt = require("rust-tools")
rt.setup({
    server = {
        capabilities = capas,
    },
})

-- Nix
lspconfig.rnix.setup {}

---------------------
-- Global mappings --
---------------------
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- User contributed tips
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
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'pd', PeekDefinition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>fo', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})







-- colorscheme
-- quiet: only comments are colored
-- zellner: light scheme
-- habamax: dark
vim.cmd([[
colorscheme habamax
hi link jsonCommentError Comment
]])


-- Nvim options
-- vim script :set mappings
local o = vim.opt
o.shell = '/usr/bin/env bash'
o.shortmess:append('I') -- no welcome message
o.smarttab = true
o.number = true
o.numberwidth = 4
o.signcolumn = 'yes'
o.ignorecase = true
o.smartcase = true
-- not working yet
-- o.winminheight = 2 -- min number of lines for any window
-- o.winheight = 2  -- min number of lines for current window
-- o.winwidth = 84 -- min number of columns used for the current window
o.undodir = '~/.vimdid'
o.undofile = true
o.scrolloff = 2 -- mininum lines above/below the cursor
o.laststatus = 2 -- always show status line
o.mouse:append('a') -- use mouse scrooling in nvim instead tmux
o.splitright = true
o.splitbelow = true
o.swapfile = false
o.formatoptions:append('np') -- :help fo-table
o.list = false -- show invisible characters defined below
--o.listchars = { extends = '»' ,precedes='«' ,tab='▸' ,nbsp= '⋅',trail='⋅' }
o.termguicolors = true
o.timeoutlen = 300
-- o.updatetime = 1000
-- o.showmatch = true -- show matching bracket


-- b: only auto wrap if I started insert mode before textwidth was reached
-- backup of files (:backup) is off by default but when overwriting a file a
-- backup is made (turn off :nowritebackup)

-- set wildmode=list:longest "activate <TAB> auto-completion for file paths
-- set wildmode=longest,list
-- set nofoldenable
-- set wildoptions=pum -- make options popup transparent
-- set pumblend=20
-- set winblend=30 -- also something with transparency


--------------
-- Mappings --
--------------
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('n', '<c-n>', ':nohlsearch<cr>')
vim.keymap.set('v', '<', '<gv') -- keep block selected when shifting
vim.keymap.set('v', '>', '>gv') -- keep block selected when shifting
vim.keymap.set('n', 'n', 'nzz') -- center search results
vim.keymap.set('n', 'N', 'Nzz') -- center search results
vim.keymap.set('n', '*', '*zz') -- center search results
vim.keymap.set('n', '#', '#zz') -- center search results
vim.keymap.set('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]]) -- search for selected text
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv") -- move highlighted text around
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv") -- move highlighted text around
vim.keymap.set('n', 'J', 'mzJ`z') -- cursor stays in place when merging lines
vim.keymap.set('n', 'gdv', '<C-w>vgd') -- goto definition. vsplit
vim.keymap.set('n', 'gds', '<C-w>sgd') -- goto definition. hsplit
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- center cursor when moving down
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- center cursor when moving up
vim.keymap.set('n', '<C-j>', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<cr>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lnext<cr>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<cr>zz')
-- vim.keymap.set('', 'C-p', 'FZF<cr>') -- no fzf integration yet TODO
-- vim.keymap.set('c', 'w!!', 'w !sudo tee %') -- does not work currently TODO
vim.keymap.set('t', '<esc>', '<C-\\><C-n>') -- goto normal mode in :terminal
vim.keymap.set('n', '<leader>r', ':source $MYVIMRC<cr>:echo "nvim config reloaded"<cr>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>x', ':x<cr>')
vim.keymap.set('n', '<leader><leader>', '<c-^>')
vim.keymap.set('n', '<leader>ee', [[:e <C-R>=expand("%:p:h") . "/" <CR>]]) -- open file adjacent to current file
vim.keymap.set('n', '<leader>p', '"*P<cr>') -- paste from system clipboard
vim.keymap.set('v', '<leader>y', '"+y') -- copy highlight to system clipboard
vim.keymap.set('n', '<leader>Y', 'ggvG"+y<C-o>') -- copy buffer to system clipboard

---------------------
-- Plugin Mappings --
---------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>S', builtin.lsp_dynamic_workspace_symbols, {})



------------------
-- Autocommands --
------------------

-- JSON
-- tell vim-commentary how to comment in json
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = 'json',
-- 	command = [[setlocal commentstring=//\ %s]],
-- })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank { timeout = 400 }
    end,
})

-- No wrap and colorcolumn for log files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "log",
    callback = function()
        vim.opt.colorcolumn = '0'
        vim.opt.wrap = false
    end,
})

-- Add todo to markdown syntax
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = '*.md',
    command = 'syntax keyword todo TODO'
})

-- Add shortcut to insert code block in markdown
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = '*.md',
    command = 'inoremap <buffer> ;c ```<cr>```<Up>'
})

