local signs = { Error = "", Warn = "", Hint = "", Info = "" }

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "" },
	severity_sort = true,
})

vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
	local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
	pcall(vim.diagnostic.reset, ns)
	return true
end

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- END Diagnostics

local navic = require 'nvim-navic'

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')


	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	-- Get signatures (and _only_ signatures) when in argument lists.
	require 'lsp_signature'.on_attach({
		doc_lines = 0,
		handler_opts = {
			border = "none"
		},
	})

	-- client.offset_encoding = "utf-16"

	--require'lsp-inlayhints'.on_attach(client, bufnr)
end

local nvim_lsp = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.offsetEncoding = "utf-8"

nvim_lsp.gopls.setup {
	on_attach = on_attach,
}
-- nvim_lsp.bufls.setup {}

require 'clangd_extensions'.setup {
	server = {
		on_attach = on_attach,
		capabilites = capabilities,
		offsetEncoding = 'utf-8',
	},
	extensions = {
		offsetEncoding = 'utf-8',
		-- autoSetHints = false,
	}
}
require 'rust-tools'.setup {
	server = {
		on_attach = on_attach,
		capabilites = capabilities,
	},
	--tools = {
	--  inlay_hints = {
	--  	auto = false
	--  }
	--}
}
require 'deno-nvim'.setup {
	server = {
		on_attach = on_attach,
		capabilites = capabilities,
		root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
		-- settings = {
		--    deno = {
		--         inlayHints = {
		--             parameterNames = {
		--                 enabled = "all"
		--             },
		--             parameterTypes = {
		--                 enabled = true
		--             },
		--             variableTypes = {
		--                 enabled = true
		--             },
		--             propertyDeclarationTypes = {
		--                 enabled = true
		--             },
		--             functionLikeReturnTypes = {
		--                 enabled = true
		--             },
		--             enumMemberValues = {
		--                 enabled = true
		--             },
		--         }
		--     }
		-- }
	},
}

require 'typescript'.setup {
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
		single_file_support = false,
	},
}
nvim_lsp.tailwindcss.setup {
	server = {
		root_dir = nvim_lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js',
			'postcss.config.ts', 'package.json')
	}
}

nvim_lsp.jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.svelte.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				-- library = vim.api.nvim_get_runtime_file("", true),
				maxPreload = 2000,
				preloadFileSize = 1000,
				library = vim.api.nvim_get_runtime_file("", true),
				--library = {
				--	"/home/pilo/.local/lua-lsp/libs/CC-Tweaked-EmmyLua"
				--}
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

--local null_ls = require'null-ls'
--
--null_ls.setup({
--    sources = {
--        null_ls.builtins.formatting.stylua,
--        null_ls.builtins.diagnostics.eslint,
--        null_ls.builtins.completion.spell,
--    },
--})

require 'nu'.setup {}
