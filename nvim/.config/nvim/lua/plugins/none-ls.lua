-- none-ls.lua: Setup for diagnostics and non-formatting LSP features via none-ls (null-ls)

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		----------------------------------------------------------------------
		-- Only include diagnostics and completion (not formatting)
		----------------------------------------------------------------------
		null_ls.setup({
			sources = {
				-- Python diagnostics
				-- null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.diagnostics.mypy,
				require("none-ls.diagnostics.ruff"),

				-- Completion
				null_ls.builtins.completion.spell,
			},

			----------------------------------------------------------------------
			-- Do NOT autoformat on save (leave to conform.nvim)
			----------------------------------------------------------------------
			on_attach = function(_, _)
				-- No formatting logic here to avoid duplication
			end,
		})
	end,
}

-- -- none-ls.lua: Setup for null-ls (none-ls) to integrate external formatters and linters into Neovim's LSP framework
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- return {
-- 	"nvimtools/none-ls.nvim",
--
-- 	config = function()
-- 		local null_ls = require("null-ls")
--
-- 		----------------------------------------------------------------------
-- 		-- Register external tools as LSP sources
-- 		----------------------------------------------------------------------
-- 		null_ls.setup({
-- 			sources = {
-- 				-- Lua
-- 				null_ls.builtins.formatting.stylua,
--
-- 				-- Python
-- 				null_ls.builtins.formatting.black,
-- 				null_ls.builtins.formatting.isort,
-- 				null_ls.builtins.diagnostics.ruff,
-- 				null_ls.builtins.diagnostics.mypy,
--
-- 				-- Web (JSON, YAML, Markdown, etc.)
-- 				null_ls.builtins.formatting.prettier,
--
-- 				-- SQL
-- 				null_ls.builtins.formatting.sqlfluff,
--
-- 				-- Completion
-- 				null_ls.builtins.completion.spell,
-- 			},
--
-- 			----------------------------------------------------------------------
-- 			-- Autoformat on save if client supports formatting
-- 			----------------------------------------------------------------------
-- 			-- on_attach = function(client, bufnr)
-- 			-- 	if client.supports_method("textDocument/formatting") then
-- 			-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			-- 			group = augroup,
-- 			-- 			buffer = bufnr,
-- 			-- 			callback = function()
-- 			-- 				vim.lsp.buf.format({ bufnr = bufnr, async = false })
-- 			-- 			end,
-- 			-- 		})
-- 			-- 	end
-- 			-- end,
-- 		})
--
-- 		----------------------------------------------------------------------
-- 		-- Manual format command (keymap handled elsewhere)
-- 		----------------------------------------------------------------------
-- 		-- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, {})
-- 	end,
-- }
