return {

	-- Command and arguments to start the server
	cmd = {
		"lua-language-server",
	},

	-- Filetypes to auto-attach to
	filetypes = {
		"lua",
	},

	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Info,
}
