-- vim.api.nvim_set_option("guicursor", "")
vim.cmd([[
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set inccommand=nosplit
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
" set backspace=2 " Backspace over newlines
set nofoldenable
]])

vim.opt.scrolloff = 8
vim.opt.ttyfast = true
-- https://github.com/vim/vim/issues/1735#issuecomment-383353563
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 500
vim.opt.showcmd = true -- Show (partial) comand in status line.m
vim.opt.mouse = 'a' -- Enable mouse usage (all modes) in terminals

vim.cmd([[
au TextYankPost * silent! lua vim.highlight.on_yank()
]]) -- Highlight yank

-- Decent wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.wildoptions = "tagfile"

-- Show those damn hidden characters
-- Verbose: vim.opt.listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
vim.opt.listchars = 'nbsp:¬,extends:»,precedes:«,trail:•'

vim.opt.number = true -- Also show current absolute line
vim.opt.relativenumber = true -- Relative line numbers
-- selected Cursorline
vim.opt.cursorline = true

-- Make diffing better: https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append('iwhite')
vim.opt.diffopt:append('algorithm:patience')
vim.opt.diffopt:append('indent-heuristic')

vim.opt.colorcolumn = "80"
vim.opt.updatetime = 300
