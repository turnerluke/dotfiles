-- Neovim LSP configuration using Mason, mason-lspconfig, and nvim-lspconfig.
-- This setup ensures language servers, linters, and formatters are installed,
-- and configures diagnostics, keymaps, and autoformatting.

return {
	-- Mason: Manages installation of formatters/linters (non-LSP tools)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		opts = {
			ensure_installed = {
				-- Python
				"ruff",
				"ty",
				"pylint",
				"mypy",
				"black",
				"isort",
				"debugpy",

				-- Web (JS/TS)
				"eslint_d",

				-- Shell
				"shellcheck",
				"zsh",

				-- Markdown
				"markdownlint",

				-- Lua
				"stylua",
				"luacheck",

				-- YAML / JSON / TOML
				"yamllint",
				"jsonlint",
				"prettier",

				-- SQL
				"sqlfluff",

				-- Docker
				"hadolint",

				-- LSPs
				"pyright",
				"lua-language-server",
			},
		},
	},
	-- Mason LSPConfig: Bridges Mason with lspconfig to install LSP servers
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ruff",
				"ty",
			},
			automatic_enable = false,
		},
	},
}
