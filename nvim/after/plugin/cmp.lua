local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup({
	snippet = {
		-- REQUIRED by nvim-cmp. get rid of it once we can
		expand = function(args)
			--vim.fn["vsnip#anonymous"](args.body)
			require 'luasnip'.lsp_expand(args.body)
		end,
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			--require("copilot_cmp.comparators").prioritize,
			--require("copilot_cmp.comparators").score,
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.recently_used,
			require 'clangd_extensions.cmp_scores',
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
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
		['<CR>'] = cmp.mapping.confirm({
			-- this is the important line
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = {
		-- Copilot Source
		{ name = "copilot", group_index = 2 },
		{ name = 'luasnip', priority = 7, group_index = 2 },
		-- Other Sources
		{ name = "nvim_lsp", priority = 8, group_index = 2 },
		{ name = "path", priority = 6, group_index = 2 },
	},
	experimental = {
		ghost_text = true,
	},
	enabled = function()
		-- disable completion in comments
		local context = require 'cmp.config.context'
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_treesitter_capture("comment")
				and not context.in_syntax_group("Comment")
		end
	end,
	formatting = {
		format = function(entry, vim_item)
			if vim.tbl_contains({ 'path' }, entry.source.name) then
				local icon, hl_group = require 'nvim-web-devicons'.get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end
			return lspkind.cmp_format({
				with_text = false,
				max_width = 50,
			})(entry, vim_item)
		end
	}
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

--local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
--
--cmp.event:on(
--	'confirm_done',
--	cmp_autopairs.on_confirm_done()
--)
