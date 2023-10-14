return {
  { "rawnly/gist.nvim", cmd = { "CreateGist", "CreateGistFromFile" } },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gvsplit", "Gvdiffsplit", "Gwrite", "Ggrep", "GDelete", "GMove" },
    keys = { { "<F3>", "<cmd>Git blame<cr>", desc = "Git blame" } },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set

        -- navigate through hunks
        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Git goto next hunk", buffer = bufnr })

        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Git goto prev hunk", buffer = bufnr })

        -- normal mode actions on hunks
        map("n", "<leader>sh", gs.stage_hunk, { desc = "Git Stage Hunk", buffer = bufnr })
        map("n", "<leader>uh", gs.undo_stage_hunk, { desc = "Git Undo Stage Hunk", buffer = bufnr })
        map("n", "<leader>rh", gs.reset_hunk, { desc = "Git Reset Hunk", buffer = bufnr })
        map("n", "<leader>ph", gs.preview_hunk, { desc = "Git Preview Hunk", buffer = bufnr })

        -- visual mode actions on hunks
        map("v", "<leader>sh", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git Stage Hunk", buffer = bufnr })
        map("v", "<leader>rh", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git Reset Hunk", buffer = bufnr })

        -- normal mode actions on buffers
        map("n", "<leader>sb", gs.stage_buffer, { desc = "Git Stage Buffer", buffer = bufnr })
        map("n", "<leader>rb", gs.reset_buffer, { desc = "Git Reset Buffer", buffer = bufnr })
      end,
    },
  },
}
