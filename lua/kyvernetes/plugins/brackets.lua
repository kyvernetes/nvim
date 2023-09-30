return {
  {
    "altermo/ultimate-autopair.nvim",
    event = "InsertEnter",
    opts = {},
  },
  {
    "gpanders/nvim-parinfer",
    config = function()
      vim.g.parinfer_force_balance = true
      vim.g.parinfer_filetypes = {
        "query",
        "dune",
        "clojure",
        "scheme",
        "lisp",
      }
    end,
  },
}
