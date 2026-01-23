local M = {}

M.base46 = {
	theme = "catppuccin",
}

M.ui = {
	statusline = { theme = "default" },

	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "treeOffset", "buffers", "tabs" },
		bufwidth = 21,
	},
}

return M
