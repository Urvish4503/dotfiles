return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local keymap = vim.keymap -- for conciseness

		-- This on_attach function will be passed to every server setup.
		-- It configures keymaps and other buffer-local settings
		-- once an LSP server attaches to a buffer.
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }

			-- Set all your keymaps here, same as you had before
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)
			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			opts.desc = "Lists symbols in current workspace"
			keymap.set("n", "<leader>ss", "<cmd>Telescope lsp_dynamic_workspace_symbols initial_mode=insert<CR>", opts)
		end

		-- Configure diagnostic signs
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Get capabilities from cmp-nvim-lsp for autocompletion
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- A list of servers to install and configure
		local servers = {
			"lua_ls",
			"clangd",
			"emmet_ls",
			"eslint",
			"gopls",
		}

		-- for _, server_name in ipairs(servers) do
		--     local server_opts = {
		--         on_attach = on_attach,
		--         capabilities = capabilities,
		--     }
		--
		--     -- Add server-specific settings here, if any
		--     if server_name == "lua_ls" then
		--         server_opts.settings = {
		--             Lua = {
		--                 diagnostics = { globals = { "vim" } },
		--                 completion = { callSnippet = "Replace" },
		--             },
		--         }
		--     end
		--
		--     -- This is the new, recommended way to set up each server
		--     lspconfig[server_name].setup(server_opts)
		-- end

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		vim.lsp.config("eslint", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		vim.lsp.config("clangd", {
			filetypes = { "c", "h", "cpp", "hpp", "cc", "objc", "objcpp" },
		})

		vim.lsp.config("gopls", {
			filetypes = { "go", "gomod" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
	end,
}
