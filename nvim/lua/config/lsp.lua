local augroup = vim.api.nvim_create_augroup
local UserGroup = augroup('Piloswine', {})

local autocmd = vim.api.nvim_create_autocmd
autocmd('LspAttach', {
    group = UserGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set('n', '<space>r', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('n', '<space>a', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<space>e', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', '<space>q', function() vim.diagnostic.set_loclist() end, opts)
	vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    end
})
