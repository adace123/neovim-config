local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

local lazy_plugins = {
	{
		"folke/lazy.nvim",
	},
	{
		"lewis6991/impatient.nvim",
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"whoIsSethDaniel/mason-tool-installer.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("plugins/lsp")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins/lsp/null-ls").setup()
		end,
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins/treesitter").setup()
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({})
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
	},
	{
		"Saecki/crates.nvim",
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	},

	-- buffers
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins/bufferline")
		end,
	},
	{
		"famiu/bufdelete.nvim",
	},

	-- tabs
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},

	-- utils
	{
		"nvim-lua/lsp-status.nvim",
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins/autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				ignore = "^$",
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	},
	{
		"SmiteshP/nvim-navic",
	},
	{
		"SmiteshP/nvim-navic",
	},

	-- completion
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins/cmp")
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-cmdline",
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
	},
	{
		"rafamadriz/friendly-snippets",
	},

	-- icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"ryanoasis/vim-devicons",
	},

	-- themes
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"catppuccin/nvim",
	},
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"folke/tokyonight.nvim",
	},
	{
		"projekt0n/github-nvim-theme",
	},
	{
		"shaunsingh/nord.nvim",
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				sign_priority = 75,
				preview_config = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("plugins/nvim-tree")
		end,
	},

	-- which-key
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins/which-key")
		end,
	},

	-- surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins/telescope")
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "kkharji/sqlite.lua" },
		},
	},
	{
		"jvgrootveld/telescope-zoxide",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "kkharji/sqlite.lua" },
		},
	},

	-- projects
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup()
		end,
	},

	-- sessions
	{
		"rmagatti/auto-session",
		config = function()
			require("plugins/session")
		end,
	},
	{
		"rmagatti/session-lens",
		config = function()
			require("session-lens").setup({
				previewer = true,
			})
		end,
	},

	-- scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
}

return lazy.setup(lazy_plugins, {})
