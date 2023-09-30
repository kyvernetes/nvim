return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>hm",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon mark a file",
      },
      {
        "<leader>hq",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>hn",
        function()
          require("harpoon.ui").nav_next()
        end,
        desc = "Harpoon go to next file",
      },
      {
        "<leader>hp",
        function()
          require("harpoon.ui").nav_prev()
        end,
        desc = "Harpoon go to prev file",
      },
    },
    opts = {},
  },
}
