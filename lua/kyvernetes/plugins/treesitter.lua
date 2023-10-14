---@diagnostic disable: missing-fields
return {
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "tjdevries/ocaml.nvim",
        keys = {
          {
            "<leader>out",
            function()
              require("ocaml.actions").update_interface_type()
            end,
            desc = "[O]caml [U]pdate [T]ype",
          },
        },
        opts = {},
      },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "luckasRanarison/tree-sitter-hypr" },
      {
        "nvim-treesitter/nvim-treesitter-context",
        keys = {
          {
            "[c",
            function()
              if vim.wo.diff then
                return "[c"
              end
              require("treesitter-context").go_to_context()
            end,
            desc = "Treesitter Goto [C]ontext",
            silent = true,
          },
        },
        opts = {
          max_lines = 3,
        },
      },
    },
    init = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
    config = function()
      local should_disable = function(lang, buf)
        local max_filesize = 2 * 1024 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      ---@diagnostic disable-next-line: inject-field
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "astro",
          "awk",
          "bash",
          "bibtex",
          "c",
          "cmake",
          "commonlisp",
          "cpp",
          "css",
          "cuda",
          "diff",
          "dockerfile",
          "doxygen",
          "embedded_template",
          "fortran",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "glsl",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "html",
          "http",
          "hypr",
          "java",
          "javascript",
          "jq",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "kotlin",
          "latex",
          "llvm",
          "lua",
          "luadoc",
          "luap",
          "luau",
          "make",
          "markdown",
          "markdown_inline",
          "menhir",
          "meson",
          "ninja",
          "ocaml",
          "ocaml_interface",
          "ocamllex",
          "passwd",
          "perl",
          "proto",
          "python",
          "query",
          "rapper",
          "regex",
          "ron",
          "rst",
          "rust",
          "scheme",
          "sql",
          "ssh_config",
          "strace",
          "svelte",
          "systemtap",
          "todotxt",
          "toml",
          "tsx",
          "typescript",
          "verilog",
          "vimdoc",
          "wgsl",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = should_disable,
        },
        incremental_selection = {
          enable = true,
          disable = should_disable,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
          disable = should_disable,
        },
        playground = {
          enable = true,
          disable = should_disable,
          updatetime = 25,
          persist_queries = false,
        },
        query_linter = {
          enable = true,
          disable = should_disable,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        matchup = {
          enable = true,
          enable_quotes = true,
          disable = should_disable,
        },
        textobjects = {
          select = {
            enable = true,
            disable = should_disable,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ao"] = "@class.outer",
              ["io"] = "@class.inner",
              ["ax"] = "@parameter.outer",
              ["ix"] = "@parameter.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]o"] = "@class.outer",
              ["]x"] = "@parameter.inner",
              ["]b"] = "@block.outer",
              ["]l"] = "@loop.outer",
              ["]i"] = "@conditional.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]O"] = "@class.outer",
              ["]X"] = "@parameter.inner",
              ["]B"] = "@block.outer",
              ["]L"] = "@loop.outer",
              ["]I"] = "@conditional.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[o"] = "@class.outer",
              ["[x"] = "@parameter.inner",
              ["[b"] = "@block.outer",
              ["[l"] = "@loop.outer",
              ["[i"] = "@conditional.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[O"] = "@class.outer",
              ["[X"] = "@parameter.inner",
              ["[B"] = "@block.outer",
              ["[L"] = "@loop.outer",
              ["[I"] = "@conditional.outer",
            },
          },
        },
      })
    end,
  },
}
