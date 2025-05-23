-- Initialize base46
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
--- Initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

-- Yank to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to EOL" })

-- Run @q macro
vim.keymap.set("n", "Q", "@q", { desc = "Run @q macro" })

-- Auto recenter when searching
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Delete/Change/Replace without Yanking
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Replace without yanking" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete to EOL without yanking" })

vim.keymap.set("n", "<leader>c", '"_c', { desc = "Change without yanking" })
vim.keymap.set("n", "<leader>C", '"_C', { desc = "Change to EOL without yanking" })

-- Yank/Put with OS Clipboard
vim.keymap.set("", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("", "<leader>Y", '"+y$', { desc = "Yank to EOL to clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from clipboard" })
