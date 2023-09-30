vim.api.nvim_create_user_command("Redir", function(ctx)
  local lines =
    vim.split(vim.api.nvim_exec2(ctx.args, { output = true })["output"], "\n", { plain = true })
  vim.cmd.vnew()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
  vim.opt_local.filetype = "redir"
end, { nargs = "+", complete = "command" })
