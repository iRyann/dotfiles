-- plugins/telescope.lua:
return{ 
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        file_ignore_patterns = { "%.git/" }
      }
    },
    config = function(_, opts)
      require("telescope").setup()
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            -- even more opts
            }
          }
        }
      }
    -- To get ui-select loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
  end
  }
}
