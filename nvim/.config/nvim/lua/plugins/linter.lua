return {
	"mfussenegger/nvim-lint",
	"rshkarin/mason-nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave" }, -- Auto-lint on these events
	config = function()
		local lint = require("lint")

		-- Define linters by filetype
		lint.linters_by_ft = {
			sql = { "sqlfluff" },
			lua = { "stylua" },
			python = { "black" },
		}

		-- Configure sqlfluff linter
		lint.linters.sqlfluff = {
			cmd = "sqlfluff", -- Ensure sqlfluff is in your PATH
			args = {
				"fix",
			},
			stream = "stdout",
			ignore_exitcode = true, -- Don't treat warnings as errors
			parser = function(output)
				local diagnostics = {}
				local ok, decoded = pcall(vim.json.decode, output)
				if not ok or type(decoded) ~= "table" then
					return diagnostics
				end

				for _, lint_result in ipairs(decoded) do
					table.insert(diagnostics, {
						lnum = lint_result.line - 1,
						col = lint_result.line_pos - 1,
						end_lnum = lint_result.line - 1,
						severity = vim.diagnostic.severity.WARN,
						message = lint_result.description,
						source = "sqlfluff",
					})
				end

				return diagnostics
			end,
		}

		-- Auto-run linting on buffer save and insert leave
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})

		-- Keybindings for manual linting and formatting
		vim.api.nvim_set_keymap(
			"n",
			"<leader>l",
			":lua require('lint').try_lint()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>f",
			":lua vim.lsp.buf.format({ async = true })<CR>",
			{ noremap = true, silent = true }
		)
	end,
 
