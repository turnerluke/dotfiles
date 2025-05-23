--[[
alpha-nvim

Creates the central dashboard when opening neovim with `nvim`.
--]]
return {

	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Header
		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("j", "󰈚   Restore Session", ":SessionRestore<CR>"),
			dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
			dashboard.button("w", "󰱼   Find word", ":Telescope live_grep<CR>"),
			dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("t", "󱥚   Themes", function()
				require("nvchad.themes").open({ style = "flat" })
			end),
			dashboard.button("c", "   Mappings", ":NvCheatsheet<CR>"),
			-- dashboard.button("c", "   Config", ":e $MYVIMRC <CR>"),
			dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
			dashboard.button("l", "󰒲   Lazy", ":Lazy<CR>"),
			-- dashboard.button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
			dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
		}
		_Gopts = {
			position = "center",
			hl = "Type",
			-- wrap = "overflow";
		}

		local function footer()
			return {
				[[ ]],
				[[ The computer scientist's main challenge is not to get confused ]],
				[[ by the complexities of his own making. ]],
				[[ ]],
				[[ -Edsger W. Dijkstra ]],
			}
		end

		dashboard.section.footer.val = footer()

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}
