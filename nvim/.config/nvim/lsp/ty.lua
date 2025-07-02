return {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	-- root_dir = vim.fs.root(0, { ".git/", "pyproject.toml" }),
	root_markers = { "pyproject.toml", ".git" },
}
