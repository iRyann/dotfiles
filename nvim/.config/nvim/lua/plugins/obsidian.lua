return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		-- refer to `:h file-pattern` for more examples
		"BufReadPre /home/ryan/.vaulty/*.md",
		"BufNewFile /home/ryan/.vaulty/*.md",
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "/home/ryan/.vaulty/0 ~ Fleeting Notes",
			},
			{
				name = "cy",
				path = "/home/ryan/.vaulty/7 ~ CY",
			},
			{
				name = "engineering",
				path = "/home/ryan/.vaulty/5 ~ Engineering Wiki",
			},
		},
	},
}
