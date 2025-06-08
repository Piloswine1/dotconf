vim.g.snacks_animate = false
vim.g.lazyvim_picker = "auto"
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.trouble_lualine = true

local opt = vim.opt
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end
