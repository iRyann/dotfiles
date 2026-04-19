return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
		},
		keys = {
			{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
			{ "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
		},
		opts = {
			auto_activate = false,
			cached_venv_automatic_activation = false,
			--search = {
			--	venvs = { ".venv", "venv", "env", ".tox", ".conda", "envs" },
			--},
		},
		config = function(_, opts)
			require("venv-selector").setup(opts)
		end,
	},
}
