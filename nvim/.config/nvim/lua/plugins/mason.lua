-- Neovim LSP configuration using Mason, mason-lspconfig, and nvim-lspconfig.
-- This setup ensures language servers, linters, and formatters are installed,
-- and configures diagnostics, keymaps, and autoformatting.

return {
	-- Mason: Manages installation of LSP servers, formatters, and linters
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Mason Tool Installer: Auto-installs formatters, linters, and other tools
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
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
				-- "eslint_d",

				-- Shell
				"shellcheck",

				-- Markdown
				-- "markdownlint",

				-- Lua
				"stylua",
				"luacheck",

				-- YAML / JSON / TOML
				"yamllint",
				-- "jsonlint",
				-- "prettier",

				-- SQL
				"sqlfluff",

				-- Docker
				"hadolint",

				-- LSPs
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
				"ruff",
				"ty",
			},
			automatic_enable = false,
		},
	},
}
