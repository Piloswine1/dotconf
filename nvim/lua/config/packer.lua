-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	--use { "zbirenbaum/copilot.lua" }
	use {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require 'copilot'.setup {
					suggestion = { enabled = false },
					panel = { enabled = false },
					filetypes = {
						cpp = false,
						yaml = false,
						markdown = false,
						help = false,
						gitcommit = false,
						gitrebase = false,
						hgcommit = false,
						svn = false,
						cvs = false,
						["."] = false,
					},
				}
			end, 100)
		end,
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require 'copilot_cmp'.setup()
		end
	}

	-- Session manager
	use {
		"olimorris/persisted.nvim",
		--module = "persisted", -- For lazy loading
		config = function()
			require("persisted").setup({
				save_dir = os.getenv("HOME") .. "/.vim/sessions/",
				use_git_branch = true,
				autoload = true,
				on_autoload_no_session = function()
					vim.notify("No existing session to load.")
				end
			})
			require("telescope").load_extension("persisted") -- To load the telescope extension
		end,
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
		config = function() require("nvim-autopairs").setup {} end
	}
	use "windwp/nvim-ts-autotag"
	use 'windwp/nvim-spectre'
	use {
		'stevearc/overseer.nvim',
		config = function() require 'overseer'.setup() end
	}
	use 'monaqa/dial.nvim'

	use 'folke/zen-mode.nvim'
	use 'xiyaowong/virtcolumn.nvim'
	--use {
	--	"Pocco81/true-zen.nvim",
	--	config = function()
	--		require("true-zen").setup {
	--			integrations = {
	--				tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
	--				lualine = true -- hide nvim-lualine (ataraxis)
	--			},
	--		}
	--	end,
	--}
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
	use 'itchyny/lightline.vim'
	use 'folke/todo-comments.nvim'
	use 'glepnir/dashboard-nvim'
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
	use "smjonas/inc-rename.nvim"

	-- Lua
	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	-- GIT
	use 'TimUntersberger/neogit'

	-- Semantic language support
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/nvim-cmp'
	use 'ray-x/lsp_signature.nvim'

	-- Inlay hints
	-- use 'lvimuser/lsp-inlayhints.nvim'

	-- Only because nvim-cmp _requires_ snippets
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

	-- LSP batteries
	use 'simrat39/rust-tools.nvim'
	use 'p00f/clangd_extensions.nvim'
	use 'sigmasd/deno-nvim'
	use 'jose-elias-alvarez/null-ls.nvim'
	use { 'LhKipp/nvim-nu', run = ':TSInstall nu' }
	use 'jose-elias-alvarez/typescript.nvim'

	-- filetype
	use 'mechatroner/rainbow_csv'

	-- use 'lvimuser/lsp-inlayhints.nvim'
	--
	-- Syntactic language support
	-- use 'rust-lang/rust.vim'
	-- use 'cespare/vim-toml', {'branch': 'main'}
	-- use 'stephpy/vim-yaml'
end)
