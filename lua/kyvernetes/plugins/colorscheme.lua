return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            rosewater = "#efc9c2",
            flamingo = "#ebb2b2",
            pink = "#f2a7de",
            mauve = "#b889f4",
            red = "#ea7183",
            maroon = "#ea838c",
            peach = "#f39967",
            yellow = "#eaca89",
            green = "#96d382",
            teal = "#78cec1",
            sky = "#91d7e3",
            sapphire = "#68bae0",
            blue = "#739df2",
            lavender = "#a0a8f6",
            text = "#b5c1f1",
            subtext1 = "#a6b0d8",
            subtext0 = "#959ec2",
            overlay2 = "#848cad",
            overlay1 = "#717997",
            overlay0 = "#63677f",
            surface2 = "#505469",
            surface1 = "#3e4255",
            surface0 = "#2c2f40",
            base = "#1a1c2a",
            mantle = "#141620",
            crust = "#0e0f16",
          },
          latte = {
            rosewater = "#c14a4a",
            flamingo = "#c14a4a",
            pink = "#945e80",
            mauve = "#945e80",
            red = "#c14a4a",
            maroon = "#c14a4a",
            peach = "#c35e0a",
            yellow = "#a96b2c",
            green = "#6c782e",
            teal = "#4c7a5d",
            sky = "#4c7a5d",
            sapphire = "#4c7a5d",
            blue = "#45707a",
            lavender = "#45707a",
            text = "#654735",
            subtext1 = "#7b5d44",
            subtext0 = "#8f6f56",
            overlay2 = "#a28368",
            overlay1 = "#b6977a",
            overlay0 = "#c9aa8c",
            surface2 = "#A79C86",
            surface1 = "#C9C19F",
            surface0 = "#DFD6B1",
            base = "#fbf1c7",
            mantle = "#F3EAC1",
            crust = "#E7DEB7",
          },
        },
        custom_highlights = function(C)
          local cmp = require("catppuccin.groups.integrations.cmp").get()
          for k, v in pairs(cmp) do
            if k:sub(8, 11) == "Kind" then
              cmp[k] = { bg = v.fg, fg = C.base }
            end
          end
          return cmp
        end,
        transparent_background = vim.b.transparent,
        dim_inactive = { enabled = not vim.b.transparent },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          functions = { "bold" },
        },
        integrations = {
          fidget = true,
          flash = true,
          gitsigns = true,
          harpoon = true,
          markdown = true,
          mason = true,
          cmp = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
          neotest = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
            inlay_hints = {
              background = true,
            },
          },
          notify = true,
          semantic_tokens = true,
          treesitter_context = true,
          treesitter = true,
          overseer = true,
          rainbow_delimiters = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          lsp_trouble = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
