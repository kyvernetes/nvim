return {
  {
    "epwalsh/obsidian.nvim",
    event = {
      "BufReadPre " .. vim.env.HOME .. "/.local/share/Cryptomator/mnt/Obsidian Notes/**.md",
      "BufNewFile " .. vim.env.HOME .. "/.local/share/Cryptomator/mnt/Obsidian Notes/**.md",
    },
    opts = {
      dir = "~/.local/share/Cryptomator/mnt/Obsidian Notes",
    },
  },
}
