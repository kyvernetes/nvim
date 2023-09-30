return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    keys = { { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
    opts = {},
  },
}
