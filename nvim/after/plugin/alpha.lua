local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
local home = os.getenv('HOME')

local function footer()
	local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

	return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

dashboard.section.header.val = {
[[                                        ]],
[[ ██████████████████████████████████████ ]],
[[ █▄ ▀█▄ ▄█▄ ▄▄ █ ▄▄ █▄ █ ▄█▄ ▄█▄ ▀█▀ ▄█ ]],
[[ ██ █▄▀ ███ ▄█▀█ ██ ██▄▀▄███ ███ █▄█ ██ ]],
[[ ▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▄▄▀▀▀▄▀▀▀▄▄▄▀▄▄▄▀▄▄▄▀ ]],
[[                                        ]],
}

dashboard.section.buttons.val = {
	dashboard.button("e",		"ﱐ  New file", ":ene<CR>"),
	dashboard.button("SPC s p",	"ﱐ  Sync packages", ":PackerSync<CR>"),
	dashboard.button("SPC s l", "  Recently latest session", ":Telescope persisted <CR>"),
	dashboard.button("SPC f h", "  Recently opened files", ":Telescope oldfiles <CR>"),
	dashboard.button("SPC f f", "  Find  File", ":Telescope find_files <CR>"),
	dashboard.button("SPC f b", "  File Browser", ":NeoTreeFloat <CR>"),
	dashboard.button("SPC f w", "  Find  word", ":Telescope live_grep <CR>"),
	dashboard.button("SPC f c", "  Open Nvim configs", ":Neotree float " .. home .. "/.config/nvim <CR>"),
}

local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
local num_plugins_tot = #vim.tbl_keys(packer_plugins)
local version = vim.version()
local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
local plugins_loaded_msg = num_plugins_loaded .. ' / ' .. num_plugins_tot.. ' plugins ﮣ loaded'
dashboard.section.footer.val = plugins_loaded_msg .. ',' .. nvim_version_info
dashboard.section.footer.opts.hl = 'Constant'

dashboard.config.opts.noautocmd = true

vim.cmd [[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
