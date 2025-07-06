local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed
		}
	end
end

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		extensions = { "neo-tree", "lazy", "fzf" },
		opts = {
			options = {
				theme = 'tokyonight'
			},
			sections = {
				lualine_b = { 'branch', { 'diff', source = diff_source }, },
			},
		}
	},

	-- icons
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"folke/snacks.nvim",
		opts = {
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false }, -- we set this in options.lua
			words = { enabled = true },
		},
		-- stylua: ignore
		keys = {
			{
				"<leader>n",
				function()
					if Snacks.config.picker and Snacks.config.picker.enabled then
						Snacks.picker.notifications()
					else
						Snacks.notifier.show_history()
					end
				end,
				desc = "Notification History"
			},
			{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
		},
	},

	-- previe line
	{
		'nacro90/numb.nvim',
		event = "VeryLazy",
		config = function()
			require('numb').setup()
		end,
	}
}
