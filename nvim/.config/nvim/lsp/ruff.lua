return {
	cmd = { "ruff server" },
	root_markers = { "pyproject.toml", ".git" },
	filetypes = { "python" },
	log_level = vim.lsp.protocol.MessageType.Info,
}
