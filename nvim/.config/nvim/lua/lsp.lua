-- lsp.lua - Language Server Protocol integration

-- Enable lsps configured in nvim/.config/nvim/lsp/
vim.lsp.enable({
    -- lua
    "lua_ls",

    -- python
    "ruff",
    "ty",

    -- toml, yaml, markdown, json, js, ts, html, css
    "prettier",
})

-- Diagnostics config
vim.diagnostic.config({
    virtual_lines = true,
    -- virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

-- Built in auto-completion disabled
--
-- -- Enable builtin auto-completion
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client:supports_method("textDocument/completion") then
-- 			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 			vim.keymap.set("i", "<C-Space>", function()
-- 				vim.lsp.completion.get()
-- 			end, { desc = "Get autocomplete suggestions" })
-- 		end
-- 	end,
-- })
