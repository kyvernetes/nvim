return {
  {
    "m4xshen/smartcolumn.nvim",
    event = "VeryLazy",
    opts = {
      custom_colorcolumn = function()
        return tostring(vim.bo.textwidth + 1)
      end,
    },
  },
}
