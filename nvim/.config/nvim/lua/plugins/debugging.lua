-- debugging.lua: Configure nvim-dap with UI, Python adapter, and keybindings

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Required async dependency
		"nvim-neotest/nvim-nio",
		-- UI for dap
		"rcarriga/nvim-dap-ui",
		-- Python adapter
		"mfussenegger/nvim-dap-python",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		----------------------------------------------------------------------
		-- Setup dap-ui
		----------------------------------------------------------------------
		dapui.setup()

		----------------------------------------------------------------------
		-- Setup Python adapter
		----------------------------------------------------------------------
		-- require("dap-python").setup("python") -- Use system/default python interpreter
		require("dap-python").setup(vim.fn.getcwd() .. "/.venv/bin/python")
		----------------------------------------------------------------------
		-- Open/close UI automatically on events
		----------------------------------------------------------------------
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		----------------------------------------------------------------------
		-- Sign symbol for breakpoints
		----------------------------------------------------------------------
		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴", -- You can also use: "🟥", ●", "🔴", or "🛑"
			texthl = "",
			linehl = "",
			numhl = "",
		})

		----------------------------------------------------------------------
		-- Keybindings for common debugging actions
		----------------------------------------------------------------------
		local map = vim.keymap.set

		map("n", "<Leader>dt", ":DapToggleBreakpoint<CR>", { desc = "DAP: Toggle Breakpoint" })
		map("n", "<Leader>dc", ":DapContinue<CR>", { desc = "DAP: Continue" })
		map("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "DAP: Terminate" })
		map("n", "<Leader>do", ":DapStepOver<CR>", { desc = "DAP: Step Over" })
		map("n", "<Leader>di", ":DapStepInto<CR>", { desc = "DAP: Step Into" })
		map("n", "<Leader>du", ":DapStepOut<CR>", { desc = "DAP: Step Out" })
		map("n", "<Leader>dr", ":lua require('dapui').toggle()<CR>", { desc = "DAP: Toggle UI" })
		map("n", "<Leader>dn", ":lua require('dap-python').test_method()", { desc = "DAP: Test Method" })
	end,
}
