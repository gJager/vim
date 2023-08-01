print("Loading config")

-- Setup paths so we can load our config
config_dir = debug.getinfo(1).source:match("@?(.*/)") .. "/../"
config_dir = vim.fn.resolve(config_dir)
plugin_dir = config_dir .. '/plugins'
treesitter_modules_dir = plugin_dir .. '/treesitter_modules'
undo_dir = config_dir .. '/undo'
vim.opt.runtimepath:append(config_dir)
vim.opt.runtimepath:append(plugin_dir)
vim.opt.packpath:append(plugin_dir)


-- Load other config files
require "config.map"
require "config.util"


-- Load plugin objects
local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")
local telescope_lga_actions = require("telescope-live-grep-args.actions")
local null_ls = require("null-ls")


-- ====================================================================
-- Basic setup
-- ====================================================================

vim.cmd [[colorscheme Papercolor]]

-- Prevent quitting when closing windows
vim.cmd [[cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>]]
-- Tabs
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4


-- Setup persistent undo
if not isdir(undo_dir) then
    print('Creating undo dir at '..undo_dir)
    os.execute('mkdir '..undo_dir) 
end
vim.opt.undodir = undo_dir
vim.opt.undofile = true


-- Make the cwd the current directory
-- vim.opt.autochdir = true


-- Put diagnostic messages in hoverwindow
vim.diagnostic.config({virtual_text = false})
vim.o.updatetime = 300
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]


-- ====================================================================
-- Mappings
-- ====================================================================


-- Set leader key to space
vim.g.mapleader = " "


-- Normal mode
nnoremaps({
    -- Stop moving a char with space
    ["<space>"] = "<nop>",

    -- Buffer navigation
    ["<leader>b"] = ":b<space>",

    -- Window navigation
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Create a terminal
    ["<leader>t"] = ":term<CR>:keepalt file<space>",


    -- Find files
    ['<leader>ff'] = telescope_builtin.find_files,


    -- Find buffers
    ['<leader>fb'] = telescope_builtin.buffers,


    -- Find with grep
    ["<leader>fg"] = ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",

})


-- Terminal mode
tnoremaps({
    -- Escape from terminal
    ["<esc>"] = "<C-\\><C-n>",
})
    

-- Telescope insert mode
telescope_insert = {
    -- I dont like their 'normal' mode. Close the telescope on escape.
    ["<esc>"] = telescope_actions.close,

    -- Keybinding to quote current prompt. Useful for grep
    -- Doesn't seem to work properly here.
    -- ["<C-m>"] = lga_actions.quote_prompt(),
}


-- lsp normal
lsp_normal = {
    ['gd'] = vim.lsp.buf.definition,
    ['gD'] = vim.lsp.buf.declaration,
    ['gr'] = telescope_builtin.lsp_references,
}

-- Ones from the sample that might be useful
--  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts
--  vim.keymap.set('n', '<space>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, bufopts)
--  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)


-- lsp insert
lsp_insert = {
    ['<C-n>'] = '<C-x><C-o>',
}




-- ====================================================================
-- Plugin initialization
-- ====================================================================

-- ========== Setup telescope ==========
require('telescope').setup({
    defaults = {
        mappings = {
            i = telescope_insert,
        },
    },
})


-- ========== Setup nvim-lspconfig ===========
local lsp_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    for k, v in pairs(lsp_normal) do
        vim.keymap.set('n', k, v, bufopts)
    end
    for k, v in pairs(lsp_insert) do
        vim.keymap.set('i', k, v, bufopts)
    end
end
 
require('lspconfig')['pyright'].setup{
    on_attach = lsp_on_attach,
}
require('lspconfig')['svelte'].setup{
    on_attach = lsp_on_attach,
}
require('lspconfig')['clangd'].setup{
    on_attach = lsp_on_attach,
}


-- ========== Setup null-lsp ===========
local sources = {
    -- Ruff for python linting
    null_ls.builtins.diagnostics.ruff.with({extra_args = {
	    "--select", "F",		-- Pyflakes: errors
	    "--select", "E",		-- pycodestyle
	    "--select", "W",		-- pycodestyle
	    "--select", "D",		-- docstrings
	    "--select", "N", 		-- pep8-naming
	    "--select", "C90", 		-- mccabe: complexity
	    "--select", "A", 		-- flakee8-builtins
    }}),
}

null_ls.setup({ sources = sources })

-- ========== Setup Treesitter ===========
require('nvim-treesitter.configs').setup {
    parser_install_dir = treesitter_modules_dir,
    highlight = {
        enable = true,
    }
}
