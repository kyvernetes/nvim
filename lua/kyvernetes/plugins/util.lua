return {
  { "nvim-lua/plenary.nvim" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "chaoren/vim-wordmotion", event = "VeryLazy" },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  {
    "ojroques/nvim-osc52",
    cond = os.getenv("SSH_CLIENT") ~= nil,
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          if vim.v.event.operator == "y" and vim.v.event.regname == "" then
            require("osc52").copy_register("+")
          end
        end,
        group = "Sen",
        desc = "OSC Yank for SSH",
      })
    end,
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      {
        "gA",
        "<Plug>(EasyAlign)",
        desc = "Text [A]lignment",
        mode = { "n", "x" },
      },
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" }, desc = "Dial Increment" },
      { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" }, desc = "Dial Decrement" },
      { "g<C-a>", "g<Plug>(dial-increment)", mode = "v", desc = "Dial Increment" },
      { "g<C-x>", "g<Plug>(dial-decrement)", mode = "v", desc = "Dial Decrement" },
    },
  },
  {
    "AckslD/nvim-FeMaco.lua",
    cmd = "FeMaco",
    opts = {},
  },
  { "nvim-tree/nvim-web-devicons" },
}
