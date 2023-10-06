local attach = require("kyvernetes.plugins.lsp.attach")

return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre *.rs", "BufNewFile *.rs" },
    opts = function()
      local mason_registry = require("mason-registry")
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      return {
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          on_attach = function(client, bufnr)
            vim.keymap.set(
              "n",
              "K",
              require("rust-tools").hover_actions.hover_actions,
              { buffer = bufnr, desc = "Rust Hover Action" }
            )
            vim.keymap.set(
              "n",
              "<Leader>ca",
              require("rust-tools").code_action_group.code_action_group,
              { buffer = bufnr, desc = "Rust Code Actions" }
            )
            attach.on_attach(client, bufnr)
          end,
          settings = {
            ["rust-analyzer"] = {
              rustfmt = { extraArgs = "+nightly" },
              checkOnSave = {
                command = "clippy",
                allFeatures = true,
                extraArgs = { "--no-deps" },
              },
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = false,
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },
        },
      })
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufReadPost Cargo.toml" },
    config = function()
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          local cmp = require("cmp")
          local cfg = cmp.get_config()
          table.insert(cfg.sources, 1, { group_index = 1, option = {}, name = "crates" })
          cmp.setup(cfg)
        end,
        desc = "Completion Source for Cargo.toml",
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    opts = function()
      return {
        on_attach = attach.on_attach,
        capabilities = attach.capabilities,
        settings = {
          complete_function_calls = true,
        },
      }
    end,
  },
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" },
    opts = {
      load_langs = { "es", "en-US" },
      init_check = true,
      path = vim.fn.stdpath("data") .. "/ltex",
      server_opts = {
        capabilities = attach.capabilities,
        on_attach = attach.on_attach,
        settings = {
          ltex = {
            diagnosticSeverity = "warning",
          },
        },
      },
    },
  },
}
