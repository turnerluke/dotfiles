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

-- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = { "clip.exe" },
			["*"] = { "clip.exe" },
		},
		paste = {
			["+"] = { "powershell.exe", "-Command", "Get-Clipboard -Raw | ForEach-Object { $_ -replace '\\r', '' }" },
			["*"] = { "powershell.exe", "-Command", "Get-Clipboard -Raw | ForEach-Object { $_ -replace '\\r', '' }" },
		},
		cache_enabled = 0,
	}
end

vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

require("mappings")
require("lsp")
