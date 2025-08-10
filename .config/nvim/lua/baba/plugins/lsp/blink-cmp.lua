local m = {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        "onsails/lspkind.nvim",
        "giuxtaposition/blink-cmp-copilot"
    },
    version = '1.*',
    optional = true,
    opts = {

        keymap = {
            ['<CR>'] = { 'select_and_accept' },
        },

        appearance = {
            nerd_font_variant = 'mono'
        },

        signature = { enabled = true },

        completion = {
            documentation = {
                auto_show_delay_ms = 200,
                auto_show = true,

            },
            menu = {
                draw = {
                    treesitter = { 'lsp' },

                    -- Components to render, grouped by column
                    columns = {
                        { 'kind_icon' },
                        { 'label',      'label_description', gap = 1 },
                        { 'source_name' }
                    },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local icon = ctx.kind_icon

                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ =
                                        require("nvim-web-devicons").get_icon(
                                            ctx.label
                                        )
                                    if dev_icon then icon = dev_icon end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end

                                return icon .. ctx.icon_gap
                            end,
                        },
                    },
                }
            }
        },

        accept = { auto_brackets = { enabled = false } },

        -- TODO: Add github at the end of the list of sources

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },

    },
    opts_extend = { "sources.default" }

}

return {}
