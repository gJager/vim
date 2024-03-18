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

})
 

-- Terminal mode
tnoremaps({
    -- Escape from terminal
    ["<esc>"] = "<C-\\><C-n>",
})
