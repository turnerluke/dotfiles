return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- Python
			python = { "ruff" },
			-- Lua
			lua = { "luacheck" },

			-- Shell
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "zsh" },
			-- YAML
			yaml = { "yamllint" },

			-- JSON
			json = { "jsonlint" },

			-- Markdown
			markdown = { "markdownlint" },

			-- SQL
			sql = { "sqlfluff" },

			-- Docker
			dockerfile = { "hadolint" },
		}

		-- Disable warnings in .lua files about "vim" global variable
		local luacheck = lint.linters.luacheck
		luacheck.args = { "--globals", "vim", "--codes" }

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
