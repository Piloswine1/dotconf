require 'autoclose'.setup {}
require 'neogit'.setup {}
require 'gitsigns'.setup {}
require 'todo-comments'.setup {}
require 'trouble'.setup {}

require 'indent_blankline'.setup {
	filetype_exclude = { "dashboard" },
	show_end_of_line = true,
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- require'nvim-tree'.setup {}
require 'neo-tree'.setup {
	window = {
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
