return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			-- File operations
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })

			-- Search operations
			vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live grep in files" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })

			-- Buffer operations
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })

			-- LSP operations
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbols in document" })
			vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Find symbols in workspace" })

			-- Git operations
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Browse git commits" })
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Browse git branches" })

			-- Help and diagnostics
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
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
