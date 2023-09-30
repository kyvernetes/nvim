---@diagnostic disable: missing-fields
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "marilari88/neotest-vitest",
    "overseer.nvim",
    "plenary.nvim",
  },
  keys = {
    {
      "<leader>tn",
      function()
        require("neotest").run.run({})
      end,
      desc = "[T]est [N]earest",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run({ vim.api.nvim_buf_get_name(0) })
      end,
      desc = "[T]est [F]ile",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<leader>dn",
      function()
        ---@diagnostic disable-next-line: missing-fields
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "[D]ebug [N]earest",
    },
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-plenary"),
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-jest")({
          cwd = require("neotest-jest").root,
        }),
      },
      discovery = {
        enabled = false,
      },
      consumers = {
        overseer = require("neotest.consumers.overseer"),
      },
      diagnostic = {
        enabled = true,
      },
      output = {
        enabled = true,
        open_on_run = false,
      },
      status = {
        enabled = true,
      },
    })
  end,
}
