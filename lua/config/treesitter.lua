-- ========== Setup Treesitter ===========
treesitter_modules_dir = plugin_dir .. '/treesitter_modules'
vim.opt.runtimepath:append(treesitter_modules_dir)

print("tresitter")
treesitter = require('nvim-treesitter')
treesitter_configs = require('nvim-treesitter.configs')
treesitter_configs.setup {
    parser_install_dir = treesitter_modules_dir,
    ensure_installed = {"c", "python"},
    highlight = {
        enable = true,
    }
}
