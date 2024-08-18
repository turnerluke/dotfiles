return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		require("neo-tree").setup({
			hijack_netrw_behavior = "open_default",
			window = {
				mappings = {
					["v"] = "open_vsplit",
				},
			},
		})
	end,
}
