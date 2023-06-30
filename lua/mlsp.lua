-------- Setup nvim-lspconfig --------
 
-- Set keybindings when a language server is used
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
 
  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Dont put the diagnostics inline
vim.diagnostic.config({virtual_text = false})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 300
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Install lsps
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
}

-------- Null - lsp --------
local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
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