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

-- nvchad tabufline, buffer navigation
vim.keymap.set("n", "<Tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "Next buffer" })

vim.keymap.set("n", "<S-Tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "Previous buffer" })

-- nvchad tabufline, tab navigation
vim.keymap.set("n", "gt", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "gT", ":tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>t", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>q", ":tabclose<CR>", { desc = "Close current tab" })
