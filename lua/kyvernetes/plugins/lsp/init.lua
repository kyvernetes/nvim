local fn = vim.fn
local diagnostic_icons = require("kyvernetes.config").diagnostics_icons

local perl_ok, perlprefix = pcall(fn.system, { "plenv", "prefix" })

local attach = require("kyvernetes.plugins.lsp.attach")

local prefix_icons = {
  ERROR = diagnostic_icons.Error,
  WARN = diagnostic_icons.Warn,
  INFO = diagnostic_icons.Info,
  HINT = diagnostic_icons.Hint,
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", opts = {} },
      { "folke/neodev.nvim", opts = {} },
      { "b0o/SchemaStore.nvim" },
      { "pmizio/typescript-tools.nvim" },
      { "barreiroleo/ltex_extra.nvim" },
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {
          text = {
            spinner = "dots",
          },
          window = {
            relative = "editor",
            blend = 19,
          },
        },
      },
      "mason.nvim",
    },
    keys = {
      {
        "[d",
        vim.diagnostic.goto_prev,
        desc = "Previous Diagnostic",
        silent = true,
      },
      {
        "]d",
        vim.diagnostic.goto_next,
        desc = "Next Diagnostic",
        silent = true,
      },
      {
        "<leader>ld",
        vim.diagnostic.open_float,
        desc = "[L]ine [D]iagnostics",
        silent = true,
      },
    },
    config = function()
      -- diagnostics setup
      for name, icon in pairs(diagnostic_icons) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = name })
      end

      vim.diagnostic.config({
        virtual_text = {
          spacing = 2,
          source = "if_many",
          prefix = function(diagnostic)
            return prefix_icons[vim.diagnostic.severity[diagnostic.severity]]
          end,
          severity = { min = vim.diagnostic.severity.WARN },
        },
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })

      -- handlers decoration setup
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- attaching one lsp at a time
      -- astro
      -- attach.setup("astro")

      -- ansible
      attach.setup("ansiblels")

      -- asm, nasm stuff
      attach.setup("asm_lsp")

      -- awk
      attach.setup("awk_ls")

      -- bash
      attach.setup("bashls")

      -- clang
      attach.setup("clangd", {
        on_attach = function(client, bufnr)
          vim.keymap.set(
            "n",
            "<leader>ch",
            "<cmd>ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "Switch Source/Header (C/C++)" }
          )
          attach.on_attach(client, bufnr)
        end,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--fallback-style=google",
          "--function-arg-placeholders",
          "--header-insertion=iwyu",
        },
        capabilities = vim.tbl_deep_extend("force", attach.capabilities, {
          offsetEncoding = { "utf-16" },
        }),
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })

      -- docker
      attach.setup("dockerls")
      attach.setup("docker_compose_language_service")

      -- fortran
      attach.setup("fortls", {
        cmd = {
          "fortls",
          "--lowercase_intrisics",
          "--hover_signature",
          "--hover_language=fortran",
          "--use_signature_help",
        },
      })

      -- golang
      attach.setup("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
            },
            completeUnimported = true,
            semanticTokens = true,
            staticcheck = true,
            usePlaceholders = true,
          },
        },
      })
      attach.setup("golangci_lint_ls")

      -- glsl
      attach.setup("glslls")

      -- html
      attach.setup("html")

      -- json
      local schemastore = require("schemastore")
      attach.setup("jsonls", {
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
        end,
        settings = {
          json = {
            format = { enable = true },
            validate = { enable = true },
          },
        },
      })

      -- lua
      attach.setup("lua_ls", {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            IntelliSense = { traceLocalSet = true },
            diagnostics = {
              globals = { "vim", "it", "describe", "before_each", "after_each", "a" },
            },
            runtime = { version = "LuaJIT" },
            hint = { enable = true },
            workspace = {
              library = { vim.env.VIMRUNTIME },
              checkThirdParty = false,
            },
          },
        },
      })

      -- cmake
      attach.setup("neocmake")

      -- markdown
      attach.setup("marksman")

      -- ocaml
      attach.setup("ocamllsp", {
        get_language_id = function(_, ftype)
          return ftype
        end,
      })

      -- perl
      if perl_ok then
        local perlversion = fn.fnamemodify(perlprefix, ":t")
        attach.setup("perlnavigator", {
          settings = {
            perlnavigator = {
              perlPath = perlprefix .. "/bin/perl",
              enableWarnings = true,
              perltidyProfile = "",
              perlcriticProfile = "",
              perlcriticEnabled = true,
              includePaths = {
                perlprefix .. "/lib/perl5/" .. perlversion,
                perlprefix .. "/lib/perl5/site_perl/" .. perlversion,
              },
            },
          },
        })
      end

      -- python
      attach.setup("pyright")
      attach.setup("ruff_lsp")

      -- svelte
      attach.setup("svelte")

      -- tailwind
      attach.setup("tailwindcss")

      -- toml
      attach.setup("taplo")

      -- tex, bib
      attach.setup("texlab", {
        settings = {
          texlab = {
            build = {
              args = {
                "-xelatex",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "%f",
              },
              executable = "latexmk",
              forwardSearchAfter = true,
              onSave = true,
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = true,
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = true,
            },
            forwardSearch = {
              executable = "zathura",
              args = {
                "--synctex-forward",
                "%l:1:%f",
                "%p",
              },
            },
          },
        },
      })

      -- verilog, systemverilog
      attach.setup("verible")

      -- wgsl
      attach.setup("wgsl_analyzer")

      -- yaml
      attach.setup("yamlls", {
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
          vim.list_extend(new_config.settings.yaml.schemas, schemastore.yaml.schemas())
        end,
        capabilities = vim.tbl_deep_extend("force", attach.capabilities, {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        }),
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            schemaStore = {
              enable = false,
              url = "",
            },
          },
        },
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    keys = {
      {
        "<leader>cap",
        function()
          require("actions-preview").code_actions()
        end,
        desc = "[C]ode [A]ction [P]review",
        silent = true,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "codelldb",
        "debugpy",
        "hadolint",
        "js-debug-adapter",
        "ltex-ls",
        "lua-language-server",
        "marksman",
        "perl-debug-adapter",
        "sonarlint-language-server",
        "verible",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
