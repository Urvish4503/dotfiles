-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

vim.opt.timeoutlen = 1000

-- Mouse support
vim.o.mouse = "a"

-- Don't show mode in command line
vim.o.showmode = false

-- Clipboard integration
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Indentation
vim.o.breakindent = true

-- Undo history
vim.o.undofile = true

-- Search behavior
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.termguicolors = true

-- UI elements
vim.o.signcolumn = "yes"

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Tab settings
vim.o.list = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Live substitution preview
vim.o.inccommand = "split"

-- Visual aids
vim.o.cursorline = true
vim.o.scrolloff = 999

-- Confirmation dialogs
vim.o.confirm = true

vim.o.showtabline = 0
