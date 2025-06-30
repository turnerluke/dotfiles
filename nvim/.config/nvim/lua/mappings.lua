-----------------------------------------------------------------------
-- keymaps.lua
-- Helper + curated key-mappings
-----------------------------------------------------------------------

--- Wrapper for `vim.keymap.set` with default options and description support
---@param mode  string|string[]  Vim mode(s) – e.g. "n", { "n", "v" }
---@param lhs   string           Key(s) pressed by the user
---@param rhs   string|function  Command or Lua function executed
---@param desc? string           Optional description for tools like which-key or Telescope
---@param opts? table            Optional extra options to pass to keymap.set
local function map(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	local default_opts = { noremap = true, silent = true }
	if desc then
		default_opts.desc = desc
	end
	local final_opts = vim.tbl_extend("force", default_opts, opts)
	vim.keymap.set(mode, lhs, rhs, final_opts)
end

-- Yank to EOL
map("n", "Y", "y$", "Yank to EOL")

-- Run @q macro
map("n", "Q", "@q", "Run @q macro")

-- Auto recenter when searching
map("n", "n", "nzz", "Next search result and recenter")
map("n", "N", "Nzz", "Previous search result and recenter")

-- Delete/Change/Replace without Yanking
map("x", "<leader>p", '"_dP', "Replace without yanking")

map("n", "<leader>d", '"_d', "Delete without yanking")
map("n", "<leader>D", '"_D', "Delete to EOL without yanking")

map("n", "<leader>c", '"_c', "Change without yanking")
map("n", "<leader>C", '"_C', "Change to EOL without yanking")

-- Yank/Put with OS Clipboard
map("", "<leader>y", '"+y', "Yank to clipboard")
map("", "<leader>Y", '"+y$', "Yank to EOL to clipboard")

map("n", "<leader>p", '"+p', "Paste after cursor from clipboard")
map("n", "<leader>P", '"+P', "Paste before cursor from clipboard")

-- nvchad tabufline, buffer navigation
map("n", "<Tab>", function()
	require("nvchad.tabufline").next()
end, "Next buffer")

map("n", "<S-Tab>", function()
	require("nvchad.tabufline").prev()
end, "Previous buffer")

-- Close buffer (works with nvchad.tabufline)
map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, "Close buffer")

-- nvchad tabufline, tab navigation
map("n", "gt", ":tabnext<CR>", "Next tab")
map("n", "gT", ":tabprev<CR>", "Previous tab")
map("n", "<leader>t", ":tabnew<CR>", "Open new tab")
map("n", "<leader>q", ":tabclose<CR>", "Close current tab")

-- Stay in visual mode after indenting or unindenting
map("v", ">", ">gv", "Indent and keep selection")
map("v", "<", "<gv", "Unindent and keep selection")

-- Disable accidentally suspending Neovim with Ctrl-z
map("n", "<C-z>", "<Nop>", "Nothing (prevent suspension)")
