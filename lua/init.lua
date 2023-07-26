print("Loading config")


-- Setup paths so we can load our config
config_dir = debug.getinfo(1).source:match("@?(.*/)") .. "/../"
config_dir = vim.fn.resolve(config_dir)
plugin_dir = config_dir .. '/plugins'
undo_dir = config_dir .. '/undo'
vim.opt.runtimepath:append(config_dir)
vim.opt.runtimepath:append(plugin_dir)
vim.opt.packpath:append(plugin_dir)


-- Load other config files
require "config.map"
require "config.telescope"
require "config.lsp"
require "config.util"


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


-- ====================================================================
-- Mappings
-- ====================================================================

-- Set leader key to space
nnoremap("<space>", "<nop>")
vim.g.mapleader = " "


-- Buffer navigation
nnoremap("<leader>b", ":b<space>")


-- Window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")


-- Create a terminal
nnoremap("<leader>t", ":term<CR>:keepalt file<space>")


-- Escape from terminal
tnoremap("<esc>", "<C-\\><C-n>")


-- Source config
nnoremap("<leader>sc", ":source " .. config_dir .. '/lua/init.lua <cr>')

