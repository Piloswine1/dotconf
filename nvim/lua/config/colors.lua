if vim.g.neovide == true then
	require 'tokyonight'.setup {}
else
	require 'tokyonight'.setup {
		on_highlights = function(hl, c)
			hl.DiagnosticUnderlineError = { italic = true, fg = c.error, sp = c.error }
			hl.DiagnosticUnderlineWarn  = { italic = true, fg = c.warning, sp = c.warning }
			hl.DiagnosticUnderlineInfo  = { italic = true, fg = c.info, sp = c.info }
			hl.DiagnosticUnderlineHint  = { italic = true, fg = c.hint, sp = c.hint }

			hl.SpellBad   = { fg = c.error, sp = c.error, italic = true }
			hl.SpellCap   = { fg = c.warning, sp = c.warning, italic = true }
			hl.SpellLocal = { fg = c.info, sp = c.info, italic = true }
			hl.SpellRare  = { fg = c.hint, sp = c.hint, italic = true }
		end,
	}
end

vim.cmd([[
set termguicolors
set background=dark

colorscheme tokyonight-storm
syntax on
]])
