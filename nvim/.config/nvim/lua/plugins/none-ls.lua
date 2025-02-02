local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
return {
	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.formatting.sqlfluff,
				-- null_ls.builtins.diagnostics.ruff,
				-- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
		-- <leader>f to format in linter.lua
		-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
