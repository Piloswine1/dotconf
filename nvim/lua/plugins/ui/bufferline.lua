local signs = { Error = "", Warn = "", Hint = "", Info = "" }
signs = {
	error = signs.Error,
	warning = signs.Warn,
	info = signs.Info,
	hint = signs.Hint,
}

local severities = {
	"error",
	"warning",
	-- "info",
	-- "hint",
}

return {
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- keys = {
		-- 	{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
		-- 	{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		-- 	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
		-- 	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
		-- 	{ "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
		-- 	{ "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
		-- 	{ "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
		-- 	{ "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
		-- 	{ "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
		-- 	{ "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
		-- },
		opts = {
			options = {
				mode = "tabs",
				-- stylua: ignore
				-- close_command = function(n) Snacks.bufdelete(n) end,
				-- stylua: ignore
				-- right_mouse_command = function(n) Snacks.bufdelete(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
}
