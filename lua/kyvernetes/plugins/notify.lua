return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1500,
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      vim.notify = function(...)
        return require("notify")(...)
      end
    end,
  },
}
