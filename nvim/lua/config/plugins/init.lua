--require 'autoclose'.setup {}
require 'neogit'.setup {}
require 'gitsigns'.setup {}
require 'todo-comments'.setup {}
require 'trouble'.setup {}

require 'indent_blankline'.setup {
	filetype_exclude = {
		"dashboard",
		"alpha",
		"help",
	},
	show_end_of_line = false,
	-- show_current_context = true,
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- require'nvim-tree'.setup {}
require 'neo-tree'.setup {
	window = {
		position = "right",
		width = 30,
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
	},
}

require 'nvim-web-devicons'.setup {
	color_icons = true,
	default = true,
}

require'numb'.setup {}
