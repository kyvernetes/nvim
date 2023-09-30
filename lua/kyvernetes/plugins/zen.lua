return {
  { "folke/twilight.nvim" },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "[Z]en Mode" } },
    opts = {
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = true },
      },
    },
  },
}
