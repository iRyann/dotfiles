-- config/env.lua
-- Détection de l'environnement d'exécution
local M = {}

M.is_ssh = vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil
M.is_windows = vim.loop.os_uname().sysname:match("Windows") ~= nil
M.username = vim.env.USER or vim.env.USERNAME or "user"
M.vault_path = vim.env.OBSIDIAN_VAULT or ("/home/" .. (vim.env.USER or "ryan") .. "/.vaulty/digitalGarden/")

return M
