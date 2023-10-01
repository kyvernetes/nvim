-- use space as both leader and local leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- install lazy.nvim, if not previously installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- set options
require("kyvernetes.options")

-- set custom filetypes
vim.filetype.add({
  pattern = {
    [".*playbook%.ya?ml"] = "yaml.ansible",
    [".*site%.ya?ml"] = "yaml.ansible",
    [".*main%.ya?ml"] = "yaml.ansible",
    [".*local%.ya?ml"] = "yaml.ansible",
    [".*requirements%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*"] = "yaml.ansible",
    [".*/host_vars/.*"] = "yaml.ansible",
    [".*%.ansible%.ya?ml"] = "yaml.ansible",
  },
  extension = {
    j2 = "jinja2",
  },
})

-- check for fzf
vim.g.fzf_available = vim.fn.executable("fzf") == 1
vim.b.transparent = false

-- lazy.nvim configurations
require("lazy").setup("kyvernetes.plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "catppuccin", "habamax" } },
  custom_keys = { ["<localleader>l"] = false },
  diff = { cmd = "diffview.nvim" },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- set autocommands
require("kyvernetes.autocmds")

-- set keymaps
require("kyvernetes.keymaps")
