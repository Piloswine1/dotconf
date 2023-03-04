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
		always_show_bufferline = false,
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
		groups = {
			options = {
				toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
			},
			items = {
				require('bufferline.groups').builtin.pinned:with({ icon = "" }),
				{
					name = "Tests", -- Mandatory
					-- highlight = { underline = true, sp = "blue" }, -- Optional
					priority = 2, -- determines where it will appear relative to other groups (Optional)
					matcher = function(buf) -- Mandatory
						return buf.filename:match('%_test')
							or buf.filename:match('%_spec')
							or buf.filename:match('%test.ts')
					end,
				},
				{
					name = "Docs",
					-- highlight = { underline = true, sp = "green" }, -- Optional
					auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
					matcher = function(buf)
						return buf.filename:match('%.md') or buf.filename:match('%.txt')
					end,
					separator = { -- Optional
						style = require('bufferline.groups').separator.tab
					},
				}
			}
		}
	}
}
