return {

    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true
    },
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         vim.cmd("colorscheme rose-pine")
    --     end
    -- },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { "alexghergh/nvim-tmux-navigation" },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup({ preset = "classic", })
            vim.diagnostic.config({ virtual_text = true })
        end
    },
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup {
                init = function()
                    require("hover.providers.lsp")
                end,
                preview_opts = {
                    border = "solid"
                },
                preview_window = false,
                title = true,
                mouse_providers = {
                    'LSP'
                },
                mouse_delay = 1000
            }
        end
    },
    { "ibhagwan/fzf-lua" },
    {
        "danymat/neogen",
        version = "*",
        config = true,
        opts = {
            vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>",
                { noremap = true, silent = true })
        }

    },
    {
        "rmagatti/auto-session",
        lazy = false,

        opts = {
            suppressed_dirs = { "~/", "/" },
        },
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function()
            require("lsp_signature").setup({
                bind = true,
                floating_window = true, -- show in floating window
                hint_enable = true,     -- disable inline hints
                handler_opts = {
                    border = "single"
                }
            })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'wakatime/vim-wakatime',
        lazy = false
    },
}
