print('loading telescope')

local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")
local telescope_lga_actions = require("telescope-live-grep-args.actions")

nnoremaps({
   -- Find files
   ['<leader>ff'] = telescope_builtin.find_files,

   -- Find buffers
   ['<leader>fb'] = telescope_builtin.buffers,

   -- Find with grep
   ["<leader>fg"] = ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
})
 
-- Telescope insert mode
telescope_insert = {
    -- I dont like their 'normal' mode. Close the telescope on escape.
    ["<esc>"] = telescope_actions.close,

    -- Keybinding to quote current prompt. Useful for grep
    -- Doesn't seem to work properly here.
    -- ["<C-m>"] = lga_actions.quote_prompt(),
}

-- ========== Setup telescope ==========
require('telescope').setup({
    defaults = {
        mappings = {
            i = telescope_insert,
        },
    },
})
