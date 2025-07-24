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
