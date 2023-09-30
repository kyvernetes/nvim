return {
  {
    "kristijanhusak/vim-dadbod-ui",
    ft = { "sql", "mysql", "plsql" },
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_help = 0
      vim.api.nvim_create_autocmd("FileType", {
        desc = "dadbod completion",
        group = vim.api.nvim_create_augroup("Dadbod", { clear = true }),
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          local cmp = require("cmp")
          local cfg = cmp.get_config()
          table.insert(
            cfg.sources,
            1,
            { name = "vim-dadbod-completion", group_index = 1, option = {} }
          )
          cmp.setup(cfg)
        end,
      })
    end,
  },
}
