return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},

	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					undo = {
						mappings = {
							i = {
								["<cr>"] = require("telescope-undo.actions").yank_additions,
								["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
								["<C-cr>"] = require("telescope-undo.actions").restore,
							},
							n = {
								["y"] = require("telescope-undo.actions").yank_additions,
								["Y"] = require("telescope-undo.actions").yank_deletions,
								["u"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			})
			require("telescope").load_extension("undo")
			vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
		end,
	},
}
