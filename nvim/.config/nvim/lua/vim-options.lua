vim.g.mapleader = " "

-- line numbering
vim.wo.relativenumber = true
vim.opt.number = true

-- Tab fixes
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Preserve undo
vim.opt.undofile = true

-- Split to Right or Below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Yank to EOL
vim.keymap.set("n", "Y", "y$", "Yank to EOL")

-- Run @q macro
vim.keymap.set("n", "Q", "@q", "Run @q macro")

-- Auto recenter when searching
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Delete/Change/Replace without Yanking
vim.keymap.set("x", "<leader>p", '"_dP', "Replace without yanking")

vim.keymap.set("n", "<leader>d", '"_d', "Delete without yanking")
vim.keymap.set("n", "<leader>D", '"_D', "Delete to EOL without yanking")

vim.keymap.set("n", "<leader>c", '"_c', "Change without yanking")
vim.keymap.set("n", "<leader>C", '"_C', "Change to EOL without yanking")

-- Yank/Put with OS Clipboard
vim.keymap.set("", "<leader>y", '"+y', "Yank to clipboard")
vim.keymap.set("", "<leader>Y", '"+y$', "Yank to EOL to clipboard")

vim.keymap.set("n", "<leader>p", '"+p', "Paste after cursor from clipboard")
vim.keymap.set("n", "<leader>P", '"+P', "Paste before cursor from clipboard")
