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

require('lualine').setup {
	options = {
		theme = 'tokyonight'
	},
	sections = {
		lualine_b = { 'branch', { 'diff', source = diff_source }, },
	},
	extensions = {
		'neo-tree',
		'fugitive'
	},
}
