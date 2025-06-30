return {
	cmd = { "ruff-lsp" },
	root_markers = { "pyproject.toml", ".git" },
	filetypes = { "python" },
	log_level = vim.lsp.protocol.MessageType.Info,
}
