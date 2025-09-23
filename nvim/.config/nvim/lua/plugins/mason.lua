-- REMPLACER COMPLÈTEMENT lua/plugins/mason.lua
return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"pyright",
				"gopls",
				"clangd", -- LSP C/C++
				"debugpy", -- Debug Python
				"cpptools", -- Debug C/C++
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- NOUVELLE API Neovim 0.11+ - Plus de require('lspconfig')
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configuration personnalisée pour certains serveurs
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				on_init = function(client)
					local venv_path = require("venv-selector").get_active_path()
					if venv_path then
						client.config.settings = client.config.settings or {}
						client.config.settings.python = client.config.settings.python or {}
						client.config.settings.python.pythonPath = venv_path
					end
				end,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			vim.lsp.config("gopls", {
				capabilities = capabilities,
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			-- Activer les serveurs (NOUVELLE API)
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pyright")
			vim.lsp.enable("gopls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("clangd")

			-- Auto-restart LSP quand venv change
			vim.api.nvim_create_autocmd("User", {
				pattern = "VenvSelectActivated",
				callback = function()
					vim.cmd("LspRestart")
				end,
			})
		end,
	},
	-- Diagnostics et keymaps LSP
	{
		"neovim/nvim-lspconfig", -- Toujours nécessaire pour les configs serveur
		config = function()
			-- Configuration diagnostics
			vim.diagnostic.config({
				virtual_text = { enabled = true },
				float = { enabled = true, border = "rounded" },
				signs = { active = true },
				underline = true,
			})

			-- Keymaps globaux pour diagnostics
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

			-- Auto-attach keymaps quand LSP s'attache
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
}
