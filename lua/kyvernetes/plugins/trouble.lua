return {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    keys = {
      {
        "<leader>dd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "[D]ocument [D]iagnostics (Trouble)",
      },
      {
        "<leader>wd",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "[W]orkspace [D]iagnostics (Trouble)",
      },
    },
    opts = { use_diagnostic_signs = true },
  },
}
