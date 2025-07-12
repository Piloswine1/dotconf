return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			terminal = { enabled = true },
		},
		keys = {
		    { [[<c-\>]], mode = {'n', 't'} , function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
		    -- { [[<c-s>]], mode = {'t'} , function() Snacks.terminal.open() end, desc = "Split Terminal" },
		},
	},
}
