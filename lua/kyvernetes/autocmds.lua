local grp = vim.api.nvim_create_augroup("Sen", { clear = true })
local au = vim.api.nvim_create_autocmd

au({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime", group = grp })

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
  group = grp,
  desc = "Highlight on Yank",
})

au("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, [["]])
    local lines = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lines then
      vim.F.npcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  group = grp,
  desc = "Restore previous cursor position",
})

au("BufWritePre", {
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    if dir and dir:find("%l+://") ~= 1 and vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  group = grp,
  desc = "Make required parent directories",
})

au("TermOpen", {
  command = "setlocal listchars= nonumber norelativenumber | startinsert",
  group = grp,
  desc = "Options for Terminal Mode",
})

au("FileType", {
  pattern = { "qf", "help", "man", "lspinfo", "tsplayground", "notify", "checkhealth", "redir" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>xit<cr>", { buffer = event.buf, silent = true })
  end,
  group = grp,
  desc = "q for quit on some non-modifiable filetypes",
})
