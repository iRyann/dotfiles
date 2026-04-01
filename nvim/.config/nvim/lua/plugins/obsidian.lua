-- nvim/.config/nvim/lua/plugins/obsidian.lua
local env = require("config.env")

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	event = {
		"BufReadPre " .. env.vault_path .. "*.md",
		"BufNewFile " .. env.vault_path .. "*.md",
	},
	opts = {
		workspaces = {
			{
				name = "engineering",
				path = env.vault_path,
			},
		},
		ui = { enable = false },
		templates = {
			folder = "Templates",
			date_format = "%Y-%m-%d-%a",
			time_format = "%H:%M",
		},
		legacy_commands = false,
	},
}
