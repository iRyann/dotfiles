-- config/options.lua 
-- Indentation intelligente
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Interface
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Recherche
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Theme
vim.cmd('colorscheme catppuccin')

-- asm-lsp
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.asm", "*.nasm", "*.s" }, -- si tu gardes .s
  callback = function(ev) vim.bo[ev.buf].filetype = "nasm" end,
})
