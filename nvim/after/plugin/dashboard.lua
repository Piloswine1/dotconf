-- Dashboard
local home = os.getenv('HOME')
local db = require 'dashboard'
local telescope = require 'telescope.builtin'

db.preview_file_height = 11
db.preview_file_width = 70
db.session_directory = home .. '/.local/nvim-sessions'
db.session_auto_save_on_exit = true
db.custom_center = {
	{ icon = '  ',
		desc = 'Recently latest session                  ',
		shortcut = 'SPC s l',
		action = 'SessionLoad' },
	{ icon = '  ',
		desc = 'Recently opened files                   ',
		action = telescope.oldfiles,
		shortcut = 'SPC f h' },
	{ icon = '  ',
		desc = 'Find  File                              ',
		action = telescope.find_files,
		shortcut = 'SPC f f' },
	{ icon = '  ',
		desc = 'File Browser                            ',
		action = 'NeoTreeFloat',
		shortcut = 'SPC f b' },
	{ icon = '  ',
		desc = 'Find  word                              ',
		action = telescope.live_grep,
		shortcut = 'SPC f w' },
	{ icon = '  ',
		desc = 'Open Nvim configs                       ',
		action = 'Neotree float ' .. home .. '/.config/nvim',
		shortcut = 'SPC f d' },
}
-- End dashboard
