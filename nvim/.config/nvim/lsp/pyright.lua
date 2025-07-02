return {
	cmd = { "pyright-langserver", "--stdio" },
	root_markers = { "pyproject.toml", "setup.py", ".git" },
	filetypes = { "python" },

	settings = {
		-- Let Ruff own formatting, linting, and import-sorting
		pyright = {
			disableOrganizeImports = true,
		},

		python = {
			analysis = {
				-- Type-checking behaviour
				typeCheckingMode = "basic", -- 'off' | 'basic' | 'strict'
				diagnosticMode = "openFilesOnly", -- don't flood unopened files
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,

				reportUnusedVariable = "none",
				reportUnusedImport = "none",
				reportUnusedFunction = "none",
				reportUnusedClass = "none",

				diagnosticSeverityOverrides = {
					-- imports
					reportMissingImports = "none",
					reportMissingModuleSource = "none",
					reportWildcardImportFromLibrary = "none",
					reportDuplicateImport = "none",

					-- unused / unreachable
					reportUnusedImport = "none",
					reportUnusedVariable = "none",
					reportUnusedClass = "none",
					reportUnusedFunction = "none",
					reportUnusedCoroutine = "none",
					reportUnusedExpression = "none",
					reportUnusedCallResult = "none",

					-- naming / privacy
					reportPrivateImportUsage = "none",
					reportPrivateUsage = "none",

					-- misc lint-style checks
					reportUnboundVariable = "none",
					reportImportCycles = "none",
					reportShadowedImports = "none",
					reportConstantRedefinition = "none",
					reportInconsistentConstructor = "none",
				},
			},
		},
	},

	-- Informative logging
	log_level = vim.lsp.protocol.MessageType.Error,
}
