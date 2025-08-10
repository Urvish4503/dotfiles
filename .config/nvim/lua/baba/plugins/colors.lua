return {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = true,
    priority = 1000,

    config = function()
        require("rose-pine").setup({
            highlight_groups = {
                -- TelescopeResultsTitle = { fg = "rose", bg = "surface" },
                -- TelescopeBorder = { fg = "rose", bg = "surface" },
                -- TelescopeSelection = { fg = "text", bg = "overlay", bold = true },
                -- TelescopeSelectionCaret = { fg = "text", bg = "highlight_med" },
                -- TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
                -- TelescopeTitle = { fg = "base", bg = "love" },
                -- TelescopePromptTitle = { fg = "base", bg = "love" },
                -- TelescopePreviewTitle = { fg = "base", bg = "foam" },
                -- TelescopePromptNormal = { bg = "overlay" },
                -- TelescopePromptBorder = { fg = "rose", bg = "overlay" },
                -- TelescopePromptPrefix = { fg = "love", bg = "overlay" },
                -- NvimTreeCursorLine = { bg = "surface" },
                -- CmpWinBorder = { fg = "overlay", bg = "base" },
            },
        })

        vim.cmd.colorscheme("rose-pine") -- load it here
    end

}
