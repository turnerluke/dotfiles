-- conform.nvim: Central formatting manager with per-language config and save hooks

return {
	"stevearc/conform.nvim",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },

	keys = {
		{
			"<leader>tF",
			function()
				if vim.g.disable_autoformat then
					vim.cmd("FormatEnable")
					vim.notify("Enabled autoformat globally")
				else
					vim.cmd("FormatDisable")
					vim.notify("Disabled autoformat globally")
				end
			end,
			desc = "Toggle autoformat globally",
		},
	},

	opts = {
		notify_on_error = true,
		log_level = vim.log.levels.DEBUG,

		-- Format on save with opt-out via global or buffer variable
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			local ft = vim.bo[bufnr].filetype
			local disable_filetypes = {}
			return {
				timeout_ms = 1000,
				lsp_fallback = ft ~= "sql" and not disable_filetypes[ft],
			}
		end,

		-- Filetype-specific formatter configuration
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			toml = { "prettier" },
			lua = { "stylua" },
			python = { "ruff" }, -- could add "black", "isort" if desired
			sql = { "sqlfluff" },
		},

		-- Example override for sqlfluff with dbt support
		-- formatters = {
		--   sqlfluff = {
		--     inherit = false,
		--     command = "sqlfluff",
		--     args = { "fix", "$FILENAME" },
		--     stdin = false,
		--     tmpfile_format = "conform.$RANDOM.$FILENAME",
		--     cwd = (function()
		--       local function root_file(files)
		--         return function(_, ctx)
		--           return vim.fs.root(ctx.dirname, files)
		--         end
		--       end
		--       return root_file({ ".sqlfluff", "dbt_project.yml" })
		--     end)(),
		--   },
		-- },
	},

	config = function(_, opts)
		require("conform").setup(opts)

		-- Commands to toggle autoformatting globally or per buffer
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
