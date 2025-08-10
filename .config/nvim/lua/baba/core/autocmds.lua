-- Highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})



vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
    callback = function()
        -- Check if LSP client with formatting capability is attached
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client.server_capabilities.documentFormattingProvider then
                vim.lsp.buf.format({
                    async = false,     -- Synchronous formatting before save
                    timeout_ms = 2000, -- Timeout for formatting
                })
                break
            end
        end
    end,
})


local function shorten_path(path)
    local shorten_if_more_than = 6 -- change this to 5, 7, etc
    -- Strip and remember the root ("/" or "~/")
    local prefix = ""
    if path:sub(1, 2) == "~/" then
        prefix = "~/"
        path = path:sub(3)
    elseif path:sub(1, 1) == "/" then
        prefix = "/"
        path = path:sub(2)
    end
    -- Split the remaining path into its components
    local parts = {}
    for part in string.gmatch(path, "[^/]+") do
        table.insert(parts, part)
    end
    -- Shorten only when there are more than shorten_if_more_than directories
    if #parts > shorten_if_more_than then
        local first = parts[1]
        local last_four = table.concat({
            parts[#parts - 3],
            parts[#parts - 2],
            parts[#parts - 1],
            parts[#parts],
        }, "/")
        return prefix .. first .. "/../" .. last_four
    end

    -- Re-attach the prefix when no shortening is needed
    return prefix .. table.concat(parts, "/")
end
-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
    local full_path = vim.fn.expand("%:p:h")
    return full_path:gsub(vim.fn.expand("$HOME"), "~")
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
    return vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
end
-- Function to update the winbar
local function update_winbar()
    local home_replaced = get_winbar_path()
    local buffer_count = get_buffer_count()
    local display_path = shorten_path(home_replaced)


    vim.opt.winbar = "%#WinBar1#%m "
        .. "%#WinBar2#("
        .. buffer_count
        .. ") "
        -- this shows the filename on the left
        .. "%#WinBar3#"
        .. vim.fn.expand("%:t")
        -- This shows the file path on the right
        .. "%*%=%#WinBar1#"
        .. display_path

    -- vim.fn.hostname():match("^[^.]+") -- for host name if needed
end
-- Winbar was not being updated after I left lazygit
vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
    callback = function(args)
        local old_mode = args.event == "ModeChanged" and vim.v.event.old_mode or ""
        local new_mode = args.event == "ModeChanged" and vim.v.event.new_mode or ""
        -- Only update if ModeChanged is relevant (e.g., leaving LazyGit)
        if args.event == "ModeChanged" then
            -- Get buffer filetype
            local buf_ft = vim.bo.filetype
            -- Only update when leaving `snacks_terminal` (LazyGit)
            if buf_ft == "snacks_terminal" or old_mode:match("^t") or new_mode:match("^n") then
                update_winbar()
            end
        else
            update_winbar()
        end
    end,
})

