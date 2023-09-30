return {
  {
    "stevearc/resession.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>rs",
        function()
          require("resession").save()
        end,
        desc = "[R]esession [S]ave",
      },
      {
        "<leader>rl",
        function()
          require("resession").load()
        end,
        desc = "[R]esession [L]oad",
      },
      {
        "<leader>rd",
        function()
          require("resession").delete()
        end,
        desc = "[R]esession [D]elete",
      },
    },
    config = function()
      local resession = require("resession")
      resession.setup({
        autosave = {
          enabled = true,
          notify = false,
        },
        tab_buf_filter = function(tabpage, bufnr)
          local dir = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
          return vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir)
        end,
        extensions = {
          quickfix = {},
          overseer = {
            status = { "RUNNING" },
          },
        },
      })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          -- Always save a special session named "last"
          resession.save("last")
        end,
      })
    end,
  },
}
