return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path",   -- source for file system paths
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",         -- vs-code like pictograms
    },

    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")


        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
            end
        end, { silent = true })

        local source_names = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            nvim_lua = "[Lua]",
            path = "[Path]",
            copilot = "[Copilot]",
        }

        local function pad_menu(text, width)
            return text .. string.rep(" ", width - #text)
        end


        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "buffer" },  -- text within current buffer
                { name = "path" },    -- file system paths
                { name = "copilot" },
            }),

            --
            -- formatting = {
            --     format = function(entry, vim_item)
            --         -- Show icons first
            --         vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol_text" })
            --
            --         -- Add source name to the right
            --         vim_item.menu = ({
            --             buffer = "[Buffer]",
            --             nvim_lsp = "[LSP]",
            --             luasnip = "[Snip]",
            --             nvim_lua = "[Lua]",
            --             path = "[Path]",
            --             copilot = "[Copilot]",
            --             -- Add more here if needed
            --         })[entry.source.name] or ""
            --
            --         return vim_item
            --     end,
            -- }
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
                    vim_item.menu = pad_menu(source_names[entry.source.name] or "", 10)
                    vim_item.abbr = vim_item.abbr .. "   "
                    return vim_item
                end
            }
        })
    end,
}
