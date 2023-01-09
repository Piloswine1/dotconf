vim.g.mapleader = " "
vim.keymap.set("n", ";", ":")

--noremap <C-A-b> :NeoTreeShowToggle<CR>
-- map <C-p> :Files<CR>
-- " <leader>s for Rg search
-- noremap <leader>s :Rg

local telescope = require('telescope.builtin')

vim.keymap.set("n", "<leader>pf", telescope.find_files, {})
vim.keymap.set("n", "<leader>s", function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set({"n", "i"}, "<C-p>", telescope.git_files, {})
vim.keymap.set("n", "<C-A-b>", ":NeoTreeShowToggle<CR>")
