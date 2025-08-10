return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', "debugloop/telescope-undo.nvim" },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")
        local actions = require("telescope.actions")



        telescope.setup({
            defaults = vim.tbl_extend("force", themes.get_ivy({
                sort_mru = true,
                sort_lastused = false,
                initial_mode = "normal",
                layout_config = {
                    preview_width = 0.4,
                },
            }), {
                file_ignore_patterns = { 'node_modules', '.git' },
                mappings = {
                    i = {
                        ["<C-q>"] = function(prompt_bufnr)
                            actions.smart_send_to_qflist(prompt_bufnr)
                            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                            if picker and picker._prompt_bufnr == prompt_bufnr then
                                actions.close(prompt_bufnr)
                            end
                        end,
                    },
                    n = {

                        ["<C-q>"] = function(prompt_bufnr)
                            actions.smart_send_to_qflist(prompt_bufnr)
                            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                            if picker and picker._prompt_bufnr == prompt_bufnr then
                                actions.close(prompt_bufnr)
                            end
                        end,
                        ["q"] = actions.close,
                        ["d"] = actions.delete_buffer,
                    },
                },
            }),
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = false,
                },
            },
        })

        require("telescope").load_extension("undo")
        vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

        vim.keymap.set("n", "<S-h>", function()
            builtin.buffers({
                layout_config = {
                    preview_width = 0.5,
                }

            })
        end)

        vim.keymap.set("n", "<leader>ff", function()
            local git_dir = vim.fn.finddir(".git", ".;")
            if git_dir ~= "" then
                builtin.git_files({
                    show_untracked = true,
                    initial_mode = "insert",

                    layout_config = {
                        preview_width = 0.6,
                    }
                })
            else
                builtin.find_files({
                    initial_mode = "insert",

                    layout_config = {
                        preview_width = 0.6,
                    }
                })
            end
        end, { desc = "Telescope smart file finder (git-aware)" })

        vim.keymap.set("n", "<leader>fg", function()
            builtin.live_grep({
                initial_mode = "insert",

                layout_config = {
                    preview_width = 0.6,
                }
            })
        end)

        vim.keymap.set("n", "<leader>fq", function()
            builtin.quickfix({
                layout_config = {
                    preview_width = 0.5,
                }
            })
        end)

        vim.keymap.set("n", "<leader>fd", function()
            builtin.diagnostics({
                layout_config = {
                    preview_width = 0.5,
                }
            })
        end)
    end
}
