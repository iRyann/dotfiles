return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  keys = {
    { ",v", "<cmd>VenvSelect<cr>" },
  },
  opts = {
    search_venv_managers = true,
    parents = 2,
    name = { ".venv", "venv", "env" },
  },
  config = function(_, opts)
    require("venv-selector").setup(opts)
  end,
}
