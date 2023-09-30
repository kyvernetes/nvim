local uv = vim.uv
local ft_to_linters = require("kyvernetes.config").linters_by_ft

local sonarlint_server = vim.env.HOME .. "/lsp-dap/sonarlint/extension/server/sonarlint-ls.jar"
local sonarlint_analyzers_prefix = vim.env.HOME .. "/lsp-dap/sonarlint/extension/analyzers"

-- borrowed (stolen) from https://github.com/stevearc/dotfiles/blob/master/.config/nvim/lua/plugins/lint.lua
return {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = ft_to_linters

      -- HACK: make typos work on all filetypes
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft]
      if linters then
        if vim.tbl_isempty(linters) then
          lint.linters_by_ft[ft] = {}
        end
        table.insert(lint.linters_by_ft[ft], "typos")
      end

      local timer = assert(uv.new_timer())
      local DEBOUNCE_MS = 500
      local bufnr = vim.api.nvim_get_current_buf()
      local cwd = nil

      vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
        callback = function()
          timer:stop()
          timer:start(
            DEBOUNCE_MS,
            0,
            vim.schedule_wrap(function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                vim.api.nvim_buf_call(bufnr, function()
                  lint.try_lint(nil, { ignore_errors = true, cwd = cwd })
                end)
              end
            end)
          )
        end,
        group = vim.api.nvim_create_augroup("Lint" .. bufnr, { clear = true }),
        desc = "Run Lint",
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("SetLintCWD", {}),
        callback = function()
          cwd = vim.lsp.buf.list_workspace_folders()[1]
          lint.try_lint(nil, { ignore_errors = true, cwd = cwd })
        end,
      })
    end,
  },
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
    ft = { "c", "cpp", "cuda", "python" },
    opts = {
      server = {
        cmd = {
          "java",
          "-jar",
          sonarlint_server,
          "-stdio",
          "-analyzers",
          sonarlint_analyzers_prefix .. "sonarcfamily.jar",
          sonarlint_analyzers_prefix .. "sonarpython.jar",
        },
      },
      filetypes = {
        "python",
        "cpp",
      },
    },
  },
}
