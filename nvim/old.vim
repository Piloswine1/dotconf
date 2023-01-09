set shell=/bin/bash

call plug#begin()
" Theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'godlygeek/tabular'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" Copilot
Plug 'github/copilot.vim'

" Utils
" Plug 'Piloswine1/carbon-now.nvim', { 'branch': 'main'}
Plug 'folke/zen-mode.nvim'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'folke/todo-comments.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'petertriho/nvim-scrollbar'
" Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
" Plug 'luukvbaal/nnn.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" Plug 'nvim-tree/nvim-tree.lua'
Plug 'folke/trouble.nvim'
" Neo tree
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
Plug 'onsails/lspkind.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" GIT
Plug 'TimUntersberger/neogit'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Inlay hints
" Plug 'lvimuser/lsp-inlayhints.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" LSP batteries
Plug 'simrat39/rust-tools.nvim'
Plug 'p00f/clangd_extensions.nvim'
Plug 'sigmasd/deno-nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
Plug 'jose-elias-alvarez/typescript.nvim'

" filetype
Plug 'mechatroner/rainbow_csv'

" Plug 'lvimuser/lsp-inlayhints.nvim'
"
" Syntactic language support
" Plug 'rust-lang/rust.vim'
" Plug 'cespare/vim-toml', {'branch': 'main'}
" Plug 'stephpy/vim-yaml'

call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
end

" Copilot disable on cpp
let g:copilot_filetypes = {
    \ 'cpp': v:false,
    \ }

lua << END
-- FIX: underlines instead of undercurls
-- see: https://github.com/microsoft/terminal/issues/7228
require'tokyonight'.setup {
	on_highlights = function(hl, c)
		hl.DiagnosticUnderlineError = { italic = true, fg = c.error, sp = c.error }
   		hl.DiagnosticUnderlineWarn  = { italic = true, fg = c.warning, sp = c.warning }
   		hl.DiagnosticUnderlineInfo  = { italic = true, fg = c.info, sp = c.info }
   		hl.DiagnosticUnderlineHint  = { italic = true, fg = c.hint, sp = c.hint }

		hl.SpellBad   = {fg = c.error, sp = c.error, italic = true }
		hl.SpellCap   = {fg = c.warning, sp = c.warning, italic= true }
   		hl.SpellLocal = {fg = c.info, sp = c.info, italic = true }
   		hl.SpellRare  = {fg = c.hint, sp = c.hint, italic = true }
	end,
}

END

set termguicolors
set background=dark

colorscheme tokyonight-storm

syntax on

" win32yank workaround as: 
let g:clipboard = {
    \   'name': 'win32yank-wsl',
    \   'copy': {
    \      '+': 'win32yank.exe -i --crlf',
    \      '*': 'win32yank.exe -i --crlf',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o --lf',
    \      '*': 'win32yank.exe -o --lf',
    \   },
    \   'cache_enabled': 0,
    \ }

let g:sneak#s_next = 1

if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

lua << END
local cmp = require'cmp'
local nvim_lsp = require'lspconfig'

-- Dashboard

local home = os.getenv('HOME')
local db = require'dashboard'

db.preview_file_height = 11
db.preview_file_width = 70
db.session_directory = home .. '/.local/nvim-sessions'
db.session_auto_save_on_exit = true
db.custom_center = {
    {icon = '  ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action ='SessionLoad'},
    {icon = '  ',
    desc = 'Recently opened files                   ',
    action =  'DashboardFindHistory',
    shortcut = 'SPC f h'},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Files',
    shortcut = 'SPC f f'},
    {icon = '  ',
    desc ='File Browser                            ',
    action =  'NeoTreeFloat',
    shortcut = 'SPC f b'},
    {icon = '  ',
    desc = 'Find  word                              ',
    action = 'Rg',
    shortcut = 'SPC f w'},
    {icon = '  ',
    desc = 'Open Nvim configs                       ',
    action = 'e ' .. home ..'/.config/nvim/init.vim',
    shortcut = 'SPC f d'},
}

-- End Dashboard

require'gitsigns'.setup {}

local colors = require'tokyonight.colors'.setup {}

require'neogit'.setup {}
require'scrollbar'.setup {
    handle = {
        color = colors.bg_highlight,
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
}
require'scrollbar.handlers.gitsigns'.setup {}
require'scrollbar.handlers.search'.setup {}

-- Diagnostics

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "" },
  severity_sort = true,
})

vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  pcall(vim.diagnostic.reset, ns)
  return true
end

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- END Diagnostics

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require'lsp_signature'.on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })

  --require'lsp-inlayhints'.on_attach(client, bufnr)
end

local lspkind = require'lspkind'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sorting = {
    comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require'clangd_extensions.cmp_scores',
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment") 
        and not context.in_syntax_group("Comment")
    end
  end,
  formatting = {
    format = function(entry, vim_item)
      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require'nvim-web-devicons'.get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
          return vim_item
        end
      end
      return lspkind.cmp_format({ with_text = false })(entry, vim_item)
    end
  }
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

require'indent_blankline'.setup {
	filetype_exclude = { "dashboard" },
    show_end_of_line = true,
}

local capabilities = require'cmp_nvim_lsp'.default_capabilities()
--capabilities.offsetEncoding = { "utf-16" }

nvim_lsp.gopls.setup {
  on_attach = on_attach,
}
-- nvim_lsp.bufls.setup {}

require'clangd_extensions'.setup {
  server = {
    on_attach = on_attach,
    capabilites = capabilities,
  },
  --extensions = {
  --  autoSetHints = false,
  --}
}
require'rust-tools'.setup {
  server = {
    on_attach = on_attach,
    capabilites = capabilities,
  },
  --tools = {
  --  inlay_hints = {
  --  	auto = false
  --  }
  --}
}
require'deno-nvim'.setup {
  server = {
    on_attach = on_attach,
    capabilites = capabilities,
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")
	-- settings = {
    --    deno = {
    --         inlayHints = {
    --             parameterNames = {
    --                 enabled = "all"
    --             },
    --             parameterTypes = {
    --                 enabled = true
    --             },
    --             variableTypes = {
    --                 enabled = true
    --             },
    --             propertyDeclarationTypes = {
    --                 enabled = true
    --             },
    --             functionLikeReturnTypes = {
    --                 enabled = true
    --             },
    --             enumMemberValues = {
    --                 enabled = true
    --             },
    --         }
    --     }
    -- }
  },
}

require'typescript'.setup{
    server = {
		on_attach = on_attach,
  		capabilities = capabilities,
		root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
    },
}
nvim_lsp.tailwindcss.setup{}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
			    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			    version = "LuaJIT",
			    -- Setup your lua path
			    path = vim.split(package.path, ";"),
				builtin = {
					os = "disable",
					io = "disable",
				},
			},
			diagnostics = {
			    -- Get the language server to recognize the `vim` global
			    globals = { },
			},
			workspace = {
			    -- Make the server aware of Neovim runtime files
			    -- library = vim.api.nvim_get_runtime_file("", true),
				maxPreload = 2000,
				preloadFileSize = 1000,
				library = {
					"/home/pilo/.local/lua-lsp/libs/CC-Tweaked-EmmyLua"
				}
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
			    enable = false,
			},
		},
	},
}

--local null_ls = require'null-ls'
--
--null_ls.setup({
--    sources = {
--        null_ls.builtins.formatting.stylua,
--        null_ls.builtins.diagnostics.eslint,
--        null_ls.builtins.completion.spell,
--    },
--})

require'nu'.setup {}

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "cpp", "rust", "toml", "javascript", "typescript", "json", "go", "bash" },
	sync_install = false,
  	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
}

-- local builtin = require'nnn'.builtin
-- require'nnn'.setup {
-- 	mappings = {
-- 	  { "<C-t>", builtin.open_in_tab },       -- open file(s) in tab
--   	  { "<C-s>", builtin.open_in_split },     -- open file(s) in split
--   	  { "<C-v>", builtin.open_in_vsplit },    -- open file(s) in vertical split
--   	  { "<C-p>", builtin.open_in_preview },   -- open file in preview split keeping nnn focused
--   	  { "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
--   	  { "<C-w>", builtin.cd_to_path },        -- cd to file directory
--   	  { "<C-e>", builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
--   	},
-- 	auto_close = false,
-- 	replace_netrw = "explorer",
-- }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require'nvim-web-devicons'.setup {
	color_icons = true;
 	default = true;
}

require'todo-comments'.setup {}

require'trouble'.setup {}

-- require'nvim-tree'.setup {}
require'neo-tree'.setup {
	window = {
		width = 30,
	},
	filesystem = {
		follow_current_file = true,
  	  	hijack_netrw_behavior = "open_current",
  	},
}

signs = {
  error = signs.Error,
  warning = signs.Warn,
  info = signs.Info,
  hint = signs.Hint,
}

local severities = {
  "error",
  "warning",
  -- "info",
  -- "hint",
}

require'bufferline'.setup {
	options = {
        mode = "tabs",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diag)
		  local s = {}
     	  for _, severity in ipairs(severities) do
     	    if diag[severity] then
     	      table.insert(s, signs[severity] .. diag[severity])
     	    end
     	  end
     	  return table.concat(s, " ")
     	end,
		offsets = {
     	  {
     	    filetype = "neo-tree",
     	    text = "Neo Tree",
     	    highlight = "Directory",
     	    text_align = "left",
     	  },
     	},
	}
}

--require'carbon-now'.setup({
--	open_cmd = "/mnt/c/Program\\ Files/Waterfox/waterfox.exe",
--	options = {
--		theme = "shades-of-purple",
--  	  	window_theme = "none",
--  	  	font_family = "Fira Code",
--  	}
--})

-- Zen mode
require'zen-mode'.setup {}

END

" Lightline
let g:lightline = {
	  \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ 'enable': {
      \   'tabline': 0
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set noshowmode
set nowrap
set printencoding=utf-8
" set signcolumn=yes

" Sane splits
set splitright
set splitbelow

" Use wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
" set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set showcmd " Show (partial) comand in status line.m
set mouse=a " Enable mouse usage (all modes) in terminals
au TextYankPost * silent! lua vim.highlight.on_yank() -- Highlight yank

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

set relativenumber " Relative line numbers
set number " Also show current absolute line

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

noremap <C-A-b> :NeoTreeShowToggle<CR>
map <C-p> :Files<CR>
" <leader>s for Rg search
noremap <leader>s :Rg

" windows clipboard
set clipboard+=unnamedplus

" No arrow keys --- force yourself to use the home row
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop