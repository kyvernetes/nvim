return {
  { "nvim-telescope/telescope-project.nvim" },
  { "ThePrimeagen/git-worktree.nvim" },
  { "AckslD/nvim-neoclip.lua", opts = {}, event = "VeryLazy" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "flash.nvim",
    },
    cmd = "Telescope",
    keys = {
      {
        "<leader>pj",
        function()
          require("telescope").extensions.project.project()
        end,
        desc = "Telescope Projects",
      },
      {
        "<leader>mp",
        "<cmd>Telescope man_pages sections=ALL<cr>",
        desc = "Telescope [M]an [P]ages",
      },
      { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Telescope [B]u[F]fers" },
      { "<leader>ht", "<cmd>Telescope help_tags<cr>", desc = "Telescope [H]elp [T]ags" },
      { "gs", "<cmd>Telescope git_status<CR>", desc = "Telescope [G]it [S]tatus" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Telescope [G]it [C]ommits" },
      {
        "<leader>ff",
        function()
          if vim.g.fzf_available then
            require("fzf-lua").files({
              cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.uv.cwd(),
              winopts = {
                height = 0.75,
                width = 0.5,
                preview = { layout = "vertical", vertical = "up:50%" },
              },
            })
          else
            require("telescope.builtin").find_files({
              cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.uv.cwd(),
            })
          end
        end,
        desc = "Find Files (root dir)",
      },
      {
        "<leader>bg",
        function()
          if vim.g.fzf_available then
            require("fzf-lua").grep_curbuf({
              winopts = { preview = { hidden = "hidden" }, height = 0.5, width = 0.6 },
              no_header = true,
            })
          else
            require("telescope.builtin").current_buffer_fuzzy_find()
          end
        end,
        desc = "Buffer Grep String",
      },
      {
        "<leader>dg",
        function()
          if vim.g.fzf_available then
            require("fzf-lua").grep_project({
              query = vim.fn.expand("<cword>"),
              prompt = "Live Grep  ",
              no_header = true,
            })
          else
            require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") })
          end
        end,
        desc = "Directory Grep String (cwd)",
      },
      {
        "<leader>rg",
        function()
          if vim.g.fzf_available then
            require("fzf-lua").grep_project({
              query = vim.fn.expand("<cword>"),
              cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.uv.cwd(),
              prompt = "Live Grep (Root dir)  ",
            })
          else
            require("telescope.builtin").live_grep({
              default_text = vim.fn.expand("<cword>"),
              cwd = vim.lsp.buf.list_workspace_folders()[1] or vim.uv.cwd(),
              prompt_title = "Live Grep (Root dir)",
            })
          end
        end,
        desc = "Root Grep String",
      },
    },
    config = function()
      local flash = function(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end

      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          multi_icon = "",
          sorting_strategy = "ascending",
          mappings = {
            n = { q = require("telescope.actions").close, s = flash },
            i = { ["<c-s>"] = flash },
          },
          layout_config = {
            horizontal = {
              prompt_position = "top",
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
          },
          current_buffer_fuzzy_find = {
            theme = "dropdown",
            previewer = false,
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("git_worktree")
    end,
  },
}
