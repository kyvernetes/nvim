return {
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          {
            text = { builtin.foldfunc },
            click = "v:lua.ScFa",
          },
          {
            sign = {
              name = { "Diagnostic" },
              colwidth = 1,
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = {
              name = { ".*" },
              colwidth = 1,
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          {
            sign = {
              name = { "GitSigns" },
              colwidth = 1,
              auto = false,
              wrap = true,
            },
            click = "v:lua.ScSa",
          },
        },
      })
    end,
  },
}
