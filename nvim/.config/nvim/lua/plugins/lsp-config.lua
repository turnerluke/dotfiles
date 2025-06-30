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
			},
			automatic_enable = true,
		},
	},
	-- 	-- LSPConfig: Core configuration for language servers
	-- 	{
	-- 		"neovim/nvim-lspconfig",
	-- 		lazy = false,
	-- 		config = function()
	-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- 			local lspconfig = require("lspconfig")
	--
	-- 			----------------------------------------------------------------------
	-- 			-- Diagnostic Signs: Configure gutter icons for LSP diagnostics
	-- 			----------------------------------------------------------------------
	--
	-- 			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
	-- 			for type, icon in pairs(signs) do
	-- 				local hl = "DiagnosticSign" .. type
	-- 				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	-- 			end
	--
	-- 			----------------------------------------------------------------------
	-- 			-- Diagnostics UI Configuration
	-- 			----------------------------------------------------------------------
	-- 			vim.diagnostic.config({
	-- 				virtual_text = true, -- Inline diagnostics text
	-- 				signs = true, -- Show signs in gutter
	-- 				underline = true, -- Underline issues in text
	-- 				update_in_insert = false, -- Don't update while typing
	-- 				severity_sort = true, -- Sort diagnostics by severity
	-- 			})
	--
	-- 			----------------------------------------------------------------------
	-- 			-- on_attach: Buffer-local key mappings when LSP is attached
	-- 			----------------------------------------------------------------------
	-- 			local function on_attach(_, bufnr)
	-- 				local nmap = function(keys, func, desc)
	-- 					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	-- 				end
	--
	-- 				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	-- 				nmap("gd", vim.lsp.buf.definition, "Go to Definition")
	-- 				nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
	-- 				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	-- 				nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
	-- 				nmap("<leader>f", function()
	-- 					vim.lsp.buf.format({ async = true })
	-- 				end, "Format Document")
	-- 			end
	-- 			------------------------------------------------------------------
	-- 			-- Custom Lua server config (optional if you're using conform/null-ls)
	-- 			------------------------------------------------------------------
	-- 			lspconfig.lua_ls.setup({
	-- 				capabilities = capabilities,
	-- 				on_attach = on_attach,
	-- 				settings = {
	-- 					Lua = {
	-- 						diagnostics = {
	-- 							globals = { "vim" }, -- Prevent `undefined global 'vim'`
	-- 						},
	-- 					},
	-- 				},
	-- 			})
	--
	-- 			------------------------------------------------------------------
	-- 			-- Custom Python server config
	-- 			------------------------------------------------------------------
	-- 			lspconfig.pyright.setup({
	-- 				capabilities = capabilities,
	-- 				on_attach = on_attach,
	-- 				settings = {
	-- 					python = {
	-- 						analysis = {
	-- 							typeCheckingMode = "basic", -- "off" | "basic" | "strict"
	-- 							reportUnusedImport = false, -- Let Ruff handle this
	-- 							reportUnusedVariable = false, -- Let Ruff handle this
	-- 						},
	-- 					},
	-- 				},
	-- 			})
	--
	-- 			lspconfig.ruff.setup({
	-- 				on_attach = on_attach,
	-- 				capabilities = capabilities,
	-- 			})
	-- 		end,
	-- 	},
}
