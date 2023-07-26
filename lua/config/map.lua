print("loading map")
-- ====================================================================
-- Functions
-- ====================================================================

function noremap(mode, binding, command)
    vim.keymap.set(mode, binding, command, {noremap = true})
end

function nnoremap(binding, command)
    noremap('n', binding, command)
end

function tnoremap(binding, command)
    noremap('t', binding, command)
end

