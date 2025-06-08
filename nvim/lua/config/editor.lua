vim.cmd('filetype plugin on')
-- vim.opt.autoindent = true
vim.opt.timeoutlen = 300
vim.opt.showmode = false
-- vim.opt.printencoding = 'utf-8'
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- vim.opt.smartindent = true

-- Sane splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use wide tabs
-- vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
-- vim.opt.tabstop = 4
-- vim.opt.expandtab = false

vim.opt.wrap = false

-- better search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- FIXME: use vim.opt
vim.cmd([[
set smartcase
set gdefault
]])
-- vim.opt.smartcase = true
-- vim.opt.gdefault = true

-- Edit history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Goto last edited
vim.cmd([[
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])

-- Too wild switch case ident
vim.opt.cinoptions= "l1"
