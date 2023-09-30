return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      user_default_options = {
        css = true,
        tailwind = true,
      },
    },
  },
  {
    "js-everts/cmp-tailwind-colors",
    opts = {},
  },
}
