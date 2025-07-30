return {
	cmd = { "prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
	root_markers = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
		"prettier.config.js",
		"package.json",
		".git",
	},
	filetypes = {
		"javascript",
		"typescript",
		"json",
		"html",
		"css",
		"markdown",
		"yaml",
		"toml", -- if using prettier-plugin-toml
	},
	log_level = vim.lsp.protocol.MessageType.Info,
}
