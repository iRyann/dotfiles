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
			search = {
				venvs = { ".venv", "venv", "env", ".tox", ".conda", "envs" },
				-- IMPORTANT : on coupe complètement le provider fd
				fd = nil,
			},
		},
		config = function(_, opts)
			require("venv-selector").setup(opts)

			-- blindage anti-crash si le plugin tente d'utiliser un venv inexistant
			local ok_path, pathmod = pcall(require, "venv-selector.path")
			if ok_path and type(pathmod.save_selected_python) == "function" then
				local _save = pathmod.save_selected_python
				pathmod.save_selected_python = function(...)
					local ok_state, state = pcall(require, "venv-selector.state")
					if not ok_state or not state.current_venv_path or state.current_venv_path == "" then
						return
					end
					return _save(...)
				end
			end
			local ok_cache, cache = pcall(require, "venv-selector.cached_venv")
			if ok_cache and type(cache.retrieve) == "function" then
				local _retrieve = cache.retrieve
				cache.retrieve = function(...)
					local ok_state, state = pcall(require, "venv-selector.state")
					if not ok_state or not state.current_venv_path or state.current_venv_path == "" then
						return nil
					end
					return _retrieve(...)
				end
			end

			-- --- détecte le bon python (symlinks ok)
			local function pybin_from_venv(venv)
				if not venv or venv == "" then
					return nil
				end
				for _, p in ipairs({
					venv .. "/bin/python",
					venv .. "/bin/python3",
					venv .. "/bin/python3.13",
				}) do
					local real = vim.loop.fs_realpath(p) or p
					if vim.fn.executable(real) == 1 then
						return real
					end
				end
				return nil
			end

			local function configure_dap_for(venv)
				local py = pybin_from_venv(venv)
				if not py then
					vim.notify(
						"venv-selector: aucun binaire Python trouvé dans " .. tostring(venv),
						vim.log.levels.WARN
					)
					return
				end
				pcall(function()
					require("dap-python").setup(py)
					vim.notify("dap-python → " .. py, vim.log.levels.INFO)
				end)
			end

			if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
				configure_dap_for(vim.env.VIRTUAL_ENV)
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "VenvSelectActivated",
				callback = function()
					configure_dap_for(vim.env.VIRTUAL_ENV)
					-- LspRestart : tu l'as déjà côté mason.lua
				end,
			})
		end,
	},
}
