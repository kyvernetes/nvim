---@diagnostic disable: missing-fields
local completion_sources = {
  buffer = "|buf|",
  nvim_lsp = "|LSP|",
  luasnip = "|snip|",
  latex_symbols = "|TeX|",
}

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- lsp source
      "hrsh7th/cmp-nvim-lsp",

      -- snippet source
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      { "L3MON4D3/cmp-luasnip-choice", opts = {} },

      -- same buffer source
      "hrsh7th/cmp-buffer",

      -- path source
      "FelipeLema/cmp-async-path",

      -- cmdline source
      "hrsh7th/cmp-cmdline",

      -- LaTeX symbol source
      "amarakon/nvim-cmp-lua-latex-symbols",

      -- tailwind colors source
      "cmp-tailwind-colors",

      -- source for lines in a buffer, might be useful
      "amarakon/nvim-cmp-buffer-lines",

      -- conventional commit completion source
      "davidsierradz/cmp-conventionalcommits",

      "clangd_extensions.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local kind_icons = require("kyvernetes.config").kind_icons

      local luasnip = require("luasnip")

      cmp.setup({
        -- snippet engine for cmp
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- border shape
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- custom formatting
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            -- item = require("tailwindcss-colorizer-cmp").formatter(entry, item)
            local icon = kind_icons[item.kind] or ""
            local src = completion_sources[entry.source.name] or ""
            item.menu = item.kind .. " " .. src
            item.kind = " " .. icon .. " "
            return item
          end,
        },

        -- custom mapping
        mapping = {
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        -- completion sources
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "luasnip_choice" },
        }, {
          { name = "lua-latex-symbols", option = { cache = true } },
          { name = "buffer", option = { keyword_length = 5 } },
          { name = "async_path" },
        }),

        -- sorting order
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require("clangd_extensions.cmp_scores"),
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        -- experimental features
        experimental = {
          native_menu = false,
          ghost_text = true,
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
