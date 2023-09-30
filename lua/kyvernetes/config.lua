local M = {}

M.linters_by_ft = {
  cmake = { "cmakelint" },
  dockerfile = { "hadolint" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  lua = { "selene" },
  make = { "checkmake" },
  perl = { "perlimports" },
  proto = { "buf_lint" },
  python = { "mypy" },
  sh = { "shellcheck" },
  systemverilog = { "verilator" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  verilog = { "verilator" },
  yaml = { "yamllint", "actionlint" },
  ["yaml.ansible"] = { "ansible_lint" },
}

local prettier = { "prettierd", "prettier" }

M.formatters_by_ft = {
  css = { prettier },
  go = { "goimports", "gofumpt" },
  html = { prettier },
  javascript = { prettier },
  javascriptreact = { prettier },
  json = { prettier },
  jsonc = { prettier },
  lua = { "stylua" },
  markdown = { prettier },
  perl = { "perlimports", "perltidy" },
  proto = { "buf" },
  python = { "isort", "black" },
  sh = { "shellharden", "shfmt" },
  typescript = { prettier },
  typescriptreact = { prettier },
  yaml = { prettier },
  ["_"] = { "trim_whitespace", "trim_newlines" },
}

M.diff_icons = {
  added = " ",
  modified = " ",
  removed = " ",
}

M.diagnostics_icons = {
  Error = " ",
  Warn = " ",
  Hint = "󰌵 ",
  Info = " ",
}

M.filestatus_icons = {
  modified = " ",
  readonly = " ",
  newfile = " ",
}

M.dap_icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

M.kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
  -- Text = "",
  -- Method = "",
  -- Function = "",
  -- Constructor = "",
  -- Field = "",
  -- Variable = "",
  -- Class = "",
  -- Interface = "",
  -- Module = "",
  -- Property = "",
  -- Unit = "",
  -- Value = "",
  -- Enum = "",
  -- Keyword = "",
  -- Snippet = "",
  -- Color = "",
  -- File = "",
  -- Reference = "",
  -- Folder = "",
  -- EnumMember = "",
  -- Constant = "",
  -- Struct = "",
  -- Event = "",
  -- Operator = "",
}

return M
