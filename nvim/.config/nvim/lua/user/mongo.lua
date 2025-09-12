vim.api.nvim_create_user_command("MongoRun", function()
  local file = vim.fn.expand("%:p") -- fichier en cours
  local cmd = string.format("tmux send-keys -t RIGHT 'mongosh < %s' C-m", file)
  os.execute(cmd)
end, {})

