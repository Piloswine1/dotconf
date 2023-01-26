require("persisted").setup({
	save_dir = os.getenv("HOME") .. "/.vim/sessions",
	use_git_branch = true,
	autoload = false,
})
require("telescope").load_extension("persisted") -- To load the telescope extension
