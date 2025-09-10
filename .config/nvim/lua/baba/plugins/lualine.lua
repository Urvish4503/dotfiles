return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
		{ "nvim-lua/plenary.nvim" },
		{ "AndreM222/copilot-lualine" },
	},
	config = function()
		local custom_icons = {
			error = " ",
			warn = " ",
			info = " ",
			hint = " ",
			added = " ",
			modified = "󰝤 ",
			modified_simple = "~ ",
			removed = " ",
			lock = " ",
		}
		local condition = {
			is_buf_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			is_git_repo = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		local config = {
			options = {
				component_separators = "",
				section_separators = "",
				always_divide_middle = true,
				theme = "rose-pine",
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		}

		local status_c = function(component)
			table.insert(config.sections.lualine_c, component)
		end
		local status_x = function(component)
			table.insert(config.sections.lualine_x, component)
		end

		-- Status line - Left
		status_c({
			function()
				return "| "
			end,
			padding = { left = 0 },
		})

		-- HACK: idk what i did here but it works
		-- Status line - Left
		-- Mode of the editor without background color
		status_c({
			"mode",
			function()
				local mode = vim.api.nvim_get_mode().mode
				return mode and mode:sub(1, 1):upper():gsub("%s+", "") or ""
			end,
			padding = { right = 1 },
			color = function()
				local mode = vim.fn.mode()
				local mode_map = {
					n = "normal",
					i = "insert",
					v = "visual",
					V = "visual",
					["\22"] = "visual", -- ctrl-v
					c = "command",
					R = "replace",
					t = "terminal",
				}

				local current = mode_map[mode]
				local hl_group = current and "lualine_a_" .. current
				if hl_group and vim.fn.hlexists(hl_group) == 1 then
					local hl = vim.api.nvim_get_hl(0, { name = hl_group })

					local function to_hex(c)
						return c and string.format("#%06x", c) or nil
					end

					return {
						fg = to_hex(hl.bg),
					}
				end
			end,
		})

		-- Mid
		status_c({
			function()
				return "%="
			end,
		})

		-- Right
		status_x({
			"copilot",
			show_colors = true,
			show_loading = true,
		})

		status_x({
			"diagnostics",
			sources = { "nvim_lsp", "nvim_diagnostic" },
			symbols = {
				error = custom_icons.error,
				warn = custom_icons.warn,
				info = custom_icons.info,
				hint = custom_icons.hint,
			},
			colored = true,
		})

		status_x({
			"diff",
			cond = condition.is_git_repo,
			source = function()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
				end
			end,
			symbols = {
				added = custom_icons.added,
				modified = custom_icons.modified_simple,
				removed = custom_icons.removed,
			},
			colored = true,
		})

		status_x({ "branch", icon = custom_icons.git_branch })

		status_x({
			function()
				return "|"
			end,
			padding = { right = 0 },
		})
		-- Setup lualine
		require("lualine").setup(config)

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.schedule(function()
					vim.opt.showtabline = 0
				end)
			end,
		})

		-- Guard against changes later
		vim.api.nvim_create_autocmd("OptionSet", {
			pattern = "showtabline",
			callback = function()
				if vim.opt.showtabline:get() ~= 0 then
					vim.opt.showtabline = 0
					print("[showtabline] Forced back to 0 (plugin tried to change it)")
				end
			end,
		})
	end,
}
