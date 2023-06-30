-- ====================================================================
-- Functions
-- ====================================================================

function noremap(mode, binding, command)
    vim.api.nvim_set_keymap(mode, binding, command, {noremap = true})
end

function nnoremap(binding, command)
    noremap('n', binding, command)
end

function tnoremap(binding, command)
    noremap('t', binding, command)
end

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

