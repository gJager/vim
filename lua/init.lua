print("Loading config")

-- Setup paths so we can load our config
config_dir = debug.getinfo(1).source:match("@?(.*/)") .. "/.."
plugin_dir = config_dir .. '/plugins'
vim.opt.runtimepath:append(config_dir)
vim.opt.runtimepath:append(plugin_dir)
vim.opt.packpath:append(plugin_dir)

-- Load other config files
require "map"
require "mlsp"

-- Tabs
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Make the cwd the current directory
vim.opt.autochdir = true


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
