local spectre = require('spectre')

vim.keymap.set("n", "<leader>S", spectre.open, {})
vim.keymap.set("n", "<leader>sw", function()
	spectre.open_visual({ select_word = true })
end)
