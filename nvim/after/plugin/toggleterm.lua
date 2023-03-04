require"toggleterm".setup {
	open_mapping = [[<c-\>]]
}

function split_terminal_right()
  local Terminal = require('toggleterm.terminal').Terminal
  Terminal:new({direction='horizontal'}):open()
end

vim.api.nvim_create_user_command('SplitTerminal', split_terminal_right, {})
vim.keymap.set({"t"}, "<c-s>", "<cmd>SplitTerminal<cr>")
