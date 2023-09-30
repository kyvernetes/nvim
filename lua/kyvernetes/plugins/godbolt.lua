return {
  {
    "p00f/godbolt.nvim",
    cmd = { "Godbolt", "GodboltCompiler" },
    opts = {
      languages = {
        cpp = { compiler = "gsnapshot", options = { "-std=c++23 -O3 -Wall -Wextra" } },
      },
      quickfix = {
        enable = true,
        auto_open = true,
      },
    },
  },
}
