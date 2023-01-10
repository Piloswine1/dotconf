vim.cmd('filetype plugin indent on')
vim.opt.autoindent = true
vim.opt.showmode = false
vim.opt.printencoding = 'utf-8'
vim.opt.scrolloff = 8
-- vim.opt.signcolumn=yes

-- Sane splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use wide tabs
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

vim.opt.wrap = false

-- Edit history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
