return {
	"zbirenbaum/copilot-cmp",
	event = "InsertEnter",
	config = function()
		require("copilot_cmp").setup()
	end,
	dependencies = {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = { "InsertEnter", "BufReadPost" },
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true, -- trigger suggestions automatically
					debounce = 75,
					keymap = {
						accept = "<C-l>", -- accept whole suggestion (multi-line)
						accept_word = "<C-j>",
						accept_line = "<C-k>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				cmp = { enabled = true },

				filetypes = {
					sh = function()
						if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
							-- disable for .env files
							return false
						end
						return true
					end,
					markdown = true,
					help = true,
					cpp = true,
					h = true,
					c = true,
					["*"] = true,
				},
			})
		end,
	},
}
