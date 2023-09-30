local debugpy = vim.env.HOME .. "/lsp-dap/debugpy/bin/python"
local codelldb_path = vim.env.HOME .. "/lsp-dap/codelldb/extension/adapter/codelldb"
local js_dap_path = vim.env.HOME .. "/lsp-dap/js-debug/src/dapDebugServer.js"
local perl_dap_path = vim.env.HOME .. "/lsp-dap/vscode-perl-debug/out/debugAdapter.js"

local dap_icons = require("kyvernetes.config").dap_icons

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "[D]ap [U]I",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "[D]ap [E]val",
            mode = { "n", "v" },
          },
        },
      },
      {
        "mfussenegger/nvim-dap-python",
        keys = {
          {
            "<leader>dpm",
            function()
              require("dap-python").test_method()
            end,
            desc = "Debug Method",
          },
          {
            "<leader>dpc",
            function()
              require("dap-python").test_class()
            end,
            desc = "Debug Class",
          },
        },
        config = function()
          require("dap-python").setup(debugpy)
        end,
      },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      { "leoluz/nvim-dap-go", config = true },
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "[D]ebug set [B]reakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "[D]ebug [C]ontinue",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "[D]ebug [R]epl open",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, sign in pairs(dap_icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          text = sign[1],
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      -- c, c++
      if not dap.adapters["codelldb"] then
        require("dap").adapters["codelldb"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = codelldb_path,
            args = {
              "--port",
              "${port}",
            },
          },
        }
      end

      for _, lang in ipairs({ "c", "cpp" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "codelldb",
              request = "launch",
              name = "Launch file",
              program = function()
                return vim.fn.input({
                  prompt = "Path to executable: ",
                  default = vim.uv.cwd() .. "/",
                  completion = "file",
                })
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
            {
              type = "codelldb",
              request = "attach",
              name = "Attach to process",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end

      -- javascript, typescript
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              js_dap_path,
              "${port}",
            },
          },
        }
      end
      for _, lang in ipairs({ "typescript", "javascript" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end

      -- perl
      if not dap.adapters["perl"] then
        require("dap").adapters["perl"] = {
          type = "executable",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              perl_dap_path,
            },
          },
        }
      end
      if not dap.configurations["perl"] then
        dap.configurations["perl"] = {
          {
            type = "perl",
            request = "launch",
            name = "Launch Perl",
            program = "${workspaceFolder}/${relativeFile}",
          },
        }
      end
    end,
  },
}
