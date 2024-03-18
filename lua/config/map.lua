-- Helper functions for other modules to be able to easily make mappings
-- =====================================================================
-- Functions
-- =====================================================================

function noremap(mode, binding, command)
    vim.keymap.set(mode, binding, command, {noremap = true})
end

function nnoremap(binding, command)
    noremap('n', binding, command)
end

function tnoremap(binding, command)
    noremap('t', binding, command)
end


function multiple_remaps(list, func)
    for k, v in pairs(list) do
        func(k, v)
    end
end

function nnoremaps(list)
    multiple_remaps(list, nnoremap)
end

function tnoremaps(list)
    multiple_remaps(list, tnoremap)
end
