return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- sql = { "sqlfluff" },
			-- lua = { "stylua" },
			python = { "ruff", "pylint" },
			-- python = { "ruff" },
			-- toml = { "prettier" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>lt", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
