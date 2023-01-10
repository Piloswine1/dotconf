local telescope = require('telescope.builtin')

vim.keymap.set("n", "<leader>pf", telescope.find_files, {})
vim.keymap.set("n", "<leader>s", function()
	local req = vim.fn.input("Grep > ")
	if string.len(req) > 0 then
		telescope.grep_string({ search = req })
	end
end)
vim.keymap.set({"n", "i"}, "<C-p>", telescope.git_files, {})
vim.keymap.set("n", "<C-A-b>", ":NeoTreeShowToggle<CR>")
