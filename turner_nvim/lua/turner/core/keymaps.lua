vim.g.mapleader = " "
-- space pv to open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Source the current file with space space
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Copy to system clipboard with space y and space Y
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
