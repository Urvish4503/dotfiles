return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "alexghergh/nvim-tmux-navigation" },
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({ preset = "classic" })
			vim.diagnostic.config({ virtual_text = true })
		end,
	},
	{
		"lewis6991/hover.nvim",
		config = function()
			require("hover").setup({
				init = function()
					require("hover.providers.lsp")
				end,
				preview_opts = {
					border = "solid",
				},
				preview_window = false,
				title = true,
				mouse_providers = {
					"LSP",
				},
				mouse_delay = 1000,
			})
		end,
	},
	{ "ibhagwan/fzf-lua" },
	{
		"danymat/neogen",
		version = "*",
		config = true,
		opts = {
			vim.api.nvim_set_keymap(
				"n",
				"<Leader>nf",
				":lua require('neogen').generate()<CR>",
				{ noremap = true, silent = true }
			),
		},
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		opts = {
			suppressed_dirs = { "~/", "/" },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},

	{
		"tpope/vim-dispatch",
		cmd = { "Dispatch", "Make", "Focus", "Start" }, -- load only when needed
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			hint_enable = false,
			doc_lines = 0, -- Set to 0 to disable showing docstrings
			handler_opts = {
				border = "single", -- double, rounded, single, shadow, none
			},
			zindex = 200,
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },

		config = function()
			require("ufo").setup({})
		end,
	},
}
