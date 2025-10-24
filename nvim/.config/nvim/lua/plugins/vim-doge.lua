return {
	"kkoomen/vim-doge",
	build = ":call doge#install()",
	event = "VeryLazy",
	init = function()
		-- vim.g.doge_enable_mappings = 1
		vim.g.doge_doc_standard_python = "google"
	end,
}
