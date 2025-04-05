return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>tF",
			function()
				-- If autoformat is currently disabled globally,
				-- then enable it globally, otherwise disable it globally
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
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			local ft = vim.bo[bufnr].filetype
			local disable_filetypes = {}
			return {
				timeout_ms = 100,
				lsp_fallback = ft ~= "sql" and not disable_filetypes[ft],
			}
		end,
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			python = { "ruff" },
			sql = { "sqlfluff" },
		},

		-- TODO: sqlfluff still doesn't work with dbt
		-- Custom formatter definition for sqlfluff:
		-- This disables stdin (so a file path is passed via $FILENAME) and adds the --force flag.
		-- formatters = {
		-- 	sqlfluff = {
		-- 		inherit = false,
		-- 		command = "sqlfluff",
		-- 		args = { "fix", "$FILENAME" },
		-- 		stdin = false,
		--
		-- 		tmpfile_format = "conform.$RANDOM.$FILENAME",
		-- 		-- Define a local helper function to find the project root
		-- 		-- by looking for either ".sqlfluff" or "dbt_project.yml".
		-- 		cwd = (function()
		-- 			local function root_file(files)
		-- 				return function(self, ctx)
		-- 					return vim.fs.root(ctx.dirname, files)
		-- 				end
		-- 			end
		-- 			return root_file({ ".sqlfluff", "dbt_project.yml" })
		-- 		end)(),
		-- 	},
		-- },
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- :FormatDisable! disables autoformat for this buffer only
				vim.b.disable_autoformat = true
			else
				-- :FormatDisable disables autoformat globally
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true, -- allows the ! variant
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
