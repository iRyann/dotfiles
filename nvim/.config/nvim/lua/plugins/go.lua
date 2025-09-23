-- REMPLACER lua/plugins/go.lua
return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		lsp_cfg = false, -- Laisser la nouvelle API gérer LSP
		lsp_keymaps = false, -- Utiliser nos keymaps globaux
	},
	config = function(_, opts)
		require("go").setup(opts)

		-- Auto-format et imports pour Go seulement
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
