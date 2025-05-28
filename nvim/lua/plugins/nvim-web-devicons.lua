return { 
  "nvim-tree/nvim-web-devicons", 
  opts = {},
  config = function(_, opts)
    require("nvim-web-devicons").setup(opts)
  end,
}
