vim.g.mapleader = " "

-- line numbering
vim.wo.relativenumber = true
vim.opt.number = true

-- Tab fixes
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.shiftwidth = 4   -- Size of an indent (use 4 spaces, or whatever you want)
vim.opt.tabstop = 4      -- Number of spaces tabs count for
vim.opt.softtabstop = 4  -- Number of spaces for editing operations like Tab

-- Preserve undo
vim.opt.undofile = true

-- Split to Right or Below
vim.opt.splitright = true
vim.opt.splitbelow = true
