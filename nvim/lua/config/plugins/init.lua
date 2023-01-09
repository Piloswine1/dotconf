-- Dashboard
local home = os.getenv('HOME')
local db = require 'dashboard'

db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
	{ icon = '  ',
		desc = 'Recently latest session                  ',
		shortcut = 'SPC s l',
		action = 'SessionLoad' },
	{ icon = '  ',
		desc = 'Recently opened files                   ',
		action = 'DashboardFindHistory',
		shortcut = 'SPC f h' },
	{ icon = '  ',
		desc = 'Find  File                              ',
		action = 'Files',
		shortcut = 'SPC f f' },
	{ icon = '  ',
		desc = 'File Browser                            ',
		action = 'NeoTreeFloat',
		shortcut = 'SPC f b' },
	{ icon = '  ',
		desc = 'Find  word                              ',
		action = 'Rg',
		shortcut = 'SPC f w' },
	{ icon = '  ',
		desc = 'Open Nvim configs                       ',
		action = 'e ' .. home .. '/.config/nvim/init.lua',
		shortcut = 'SPC f d' },
}
-- End dashboard

require 'autoclose'.setup {}
require 'gitsigns'.setup {}

local colors = require 'tokyonight.colors'.setup {}

require 'neogit'.setup {}
require 'scrollbar'.setup {
	handle = {
		color = colors.bg_highlight,
	},
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	}
}
require 'scrollbar.handlers.gitsigns'.setup {}
require 'scrollbar.handlers.search'.setup {}

require 'indent_blankline'.setup {
	filetype_exclude = { "dashboard" },
	show_end_of_line = true,
}

require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "cpp", "rust", "toml", "javascript", "typescript", "json", "go", "bash" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
}
require 'treesitter-context'.setup {}

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

require 'todo-comments'.setup {}

require 'trouble'.setup {}

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

require 'bufferline'.setup {
	options = {
		mode = "tabs",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diag)
			local s = {}
			for _, severity in ipairs(severities) do
				if diag[severity] then
					table.insert(s, signs[severity] .. diag[severity])
				end
			end
			return table.concat(s, " ")
		end,
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo Tree",
				highlight = "Directory",
				text_align = "left",
			},
		},
	}
}

require 'zen-mode'.setup {}
