return {
	"stevearc/conform.nvim",
	opts = {
		-- Your list of formatters
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofmt", "goimports" },
			python = { "isort", "black" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			c = { "clangformat" },
			cpp = { "clangformat" },
			json = { "prettierd" },
		},
	},
	-- This part replaces your old autocommand
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
