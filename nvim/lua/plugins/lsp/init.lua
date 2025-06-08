local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		lazy = true,
		config = function()
			require("luasnip").setup()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require "cmp"
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- they way you will only jump inside the snippet region
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm(),
				}),
				sources = cmp.config.sources({
					-- { name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", priority = 3 },
					{ name = 'luasnip',  priority = 5 },
					{ name = "path" },
					{ name = 'buffer' },
				}),
				-- enabled = function()
				-- 	-- disable completion in comments
				-- 	local context = require 'cmp.config.context'
				-- 	-- keep command mode completion enabled when cursor is in a comment
				-- 	if vim.api.nvim_get_mode().mode == 'c' then
				-- 		return true
				-- 	else
				-- 		return not context.in_treesitter_capture("comment")
				-- 		    and not context.in_syntax_group("Comment")
				-- 	end
				-- end,
			})

			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Enable completing paths in :
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{
						name = 'cmdline',
						option = {
							ignore_cmds = { 'Man', '!' }
						}
					}
				})
			})

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("User", { pattern = "CmpReady", modeline = false })
			end)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			"stevearc/conform.nvim",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			-- "hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-buffer",
			-- "hrsh7th/cmp-path",
			-- "hrsh7th/nvim-cmp",
			-- "saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			-- local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities())
				-- cmp_lsp.default_capabilities())

			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_enable = true,
				automatic_installation = false,
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"gopls",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup {
							capabilities = capabilities
						}
					end,

					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup {
							capabilities = capabilities,
							settings = {
								Lua = {
									format = {
										enable = true,
										-- Put format options here
										-- NOTE: the value should be STRING!!
										defaultConfig = {
											indent_style = "space",
											indent_size = "2",
										}
									},
								}
							}
						}
					end,
				}
			})


			vim.diagnostic.config({
				-- update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})
		end
	},
}
