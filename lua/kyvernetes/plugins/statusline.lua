return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local cfg = require("kyvernetes.config")
      local diff_icons = cfg.diff_icons
      local diagnostics_icons = cfg.diagnostics_icons
      local filestatus_icons = cfg.filestatus_icons

      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = {
            { "mode" },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
            },
            {
              "diff",
              symbols = diff_icons,
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = diagnostics_icons.Error,
                warn = diagnostics_icons.Warn,
                hint = diagnostics_icons.Hint,
                info = diagnostics_icons.Info,
              },
            },
            { "overseer" },
            { "%=" },
            {
              "filetype",
              icon_only = true,
              padding = 0,
            },
            {
              "filename",
              symbols = filestatus_icons,
            },
          },
          lualine_x = {
            "searchcount",
          },
          lualine_y = { "filetype", "encoding", "fileformat" },
          lualine_z = {
            {
              "location",
              fmt = function(str)
                return "" .. str
              end,
            },
          },
        },
        extensions = {},
      })
    end,
  },
}
