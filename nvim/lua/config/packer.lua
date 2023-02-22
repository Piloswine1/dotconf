-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Startup time
	use 'lewis6991/impatient.nvim'
	use 'dstein64/vim-startuptime'

	-- Session manager
	use {
		"olimorris/persisted.nvim",
		--module = "persisted", -- For lazy loading
	}

	-- Utils: git, close, motion, etc...
	use 'tpope/vim-fugitive'
	use 'mbbill/undotree'
	use 'editorconfig/editorconfig-vim'
	use 'justinmk/vim-sneak'
	use 'godlygeek/tabular'
	use 'nvim-lua/plenary.nvim'
	use 'MunifTanjim/nui.nvim'
	-- use 'm4xshen/autoclose.nvim'
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {
				disable_filetype = { "TelescopePrompt", "vim" },
			}
		end
	}
	use "windwp/nvim-ts-autotag"
	use 'windwp/nvim-spectre'
	use 'monaqa/dial.nvim'
	-- Comments
	use 'numToStr/Comment.nvim'
	use 'JoosepAlviste/nvim-ts-context-commentstring'

	-- Zen
	use 'folke/zen-mode.nvim'
	-- text width line
	-- use 'xiyaowong/virtcolumn.nvim'
	-- Theme
	use 'folke/tokyonight.nvim'

	-- Fzf
	use 'airblade/vim-rooter'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or, branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	-- GUI
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'folke/todo-comments.nvim'
	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
	}
	use 'kevinhwang91/nvim-hlslens'
	use 'petertriho/nvim-scrollbar'
	use 'andymass/vim-matchup'
	use 'lukas-reineke/indent-blankline.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'nvim-treesitter/nvim-treesitter-context'
	use 'lewis6991/gitsigns.nvim'
	use 'nvim-tree/nvim-web-devicons'
	-- use 'luukvbaal/nnn.nvim'
	use 'folke/trouble.nvim'
	-- Diff
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
	-- Neo tree
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}
	-- use 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
	use 'onsails/lspkind.nvim'
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
	use({
		"utilyre/barbecue.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require 'barbecue'.setup()
		end,
	})

	use {
		'j-hui/fidget.nvim',
		config = function()
			require 'fidget'.setup {}
		end
	}

	-- Lua
	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {}
		end
	}

	-- GIT
	use 'TimUntersberger/neogit'

	-- Semantic language support
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/nvim-cmp'
	use 'ray-x/lsp_signature.nvim'
	-- use {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require 'copilot'.setup {
	-- 				suggestion = { enabled = false },
	-- 				panel = { enabled = false },
	-- 				-- filetypes = {
	-- 				-- 	yaml = false,
	-- 				-- 	markdown = false,
	-- 				-- 	help = false,
	-- 				-- 	gitcommit = false,
	-- 				-- 	gitrebase = false,
	-- 				-- 	hgcommit = false,
	-- 				-- 	svn = false,
	-- 				-- 	cvs = false,
	-- 				-- 	cpp = false,
	-- 				-- 	["."] = false,
	-- 				-- },
	-- 			}
	-- 		end, 100)
	-- 	end,
	-- }
	-- use {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "copilot.lua" },
	-- 	config = function()
	-- 		require 'copilot_cmp'.setup()
	-- 	end
	-- }
	--Snippets
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"

	-- Inlay hints
	-- use 'lvimuser/lsp-inlayhints.nvim'

	-- LSP batteries
	use 'simrat39/rust-tools.nvim'
	use 'p00f/clangd_extensions.nvim'
	use 'sigmasd/deno-nvim'
	use 'jose-elias-alvarez/null-ls.nvim'
	use { 'LhKipp/nvim-nu', run = ':TSInstall nu' }
	use 'jose-elias-alvarez/typescript.nvim'

	-- filetype
	use 'mechatroner/rainbow_csv'
	use 'peterhoeg/vim-qml'

	-- Syntactic language support
	-- use 'rust-lang/rust.vim'
	-- use 'cespare/vim-toml', {'branch': 'main'}
	-- use 'stephpy/vim-yaml'
end)
