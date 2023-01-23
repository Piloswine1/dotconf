require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "cpp", "rust", "toml", "javascript", "typescript", "json", "go", "bash" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	}
}
require 'treesitter-context'.setup {}
