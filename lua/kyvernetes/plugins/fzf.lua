return {
  {
    "ibhagwan/fzf-lua",
    enabled = vim.g.fzf_available,
    cmd = "FzfLua",
    opts = { previewers = { man = { cmd = "man %s | col -bx" } } },
  },
}
