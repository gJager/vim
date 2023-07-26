print('loading telescope')
require("config/map")

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local lga_actions = require("telescope-live-grep-args.actions")

-- Setup telescope
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                -- I dont like their 'normal' mode. Close the telescope on escape.
                ["<esc>"] = actions.close,
                -- Keybinding to quote current prompt. Useful for grep
                ["<C-m>"] = lga_actions.quote_prompt(),
            },
        },
    },
})

-- Key bindings
nnoremap('<leader>ff', builtin.find_files)
nnoremap('<leader>fb', builtin.buffers)
nnoremap("<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

