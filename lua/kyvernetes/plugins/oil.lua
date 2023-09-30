return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      {
        "<F2>",
        function()
          require("oil").toggle_float()
        end,
        desc = "Oil File Explorer (cwd)",
      },
    },
    opts = {
      columns = {
        "icon",
      },
      delete_to_trash = true,
      trash_command = "gio trash",
      skip_confirm_for_simple_edits = true,
      float = {
        padding = 0,
        max_width = 40,
        override = function(conf)
          conf["col"] = vim.o.columns - conf.width
          conf["zindex"] = 80
        end,
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local dontshow = { "node_modules" }
          return vim.tbl_contains(dontshow, name)
        end,
      },
    },
  },
}
