local M = {}

M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

M.on_attach = function(client, bufnr)
  local au = vim.api.nvim_create_autocmd
  local aug = vim.api.nvim_create_augroup

  local map = function(key, func, opts)
    if not opts.has or client.supports_method(opts.has) then
      vim.keymap.set(
        opts.mode or "n",
        key,
        func,
        vim.tbl_deep_extend("force", { silent = true, buffer = bufnr }, opts.opts)
      )
    end
  end

  map("gD", vim.lsp.buf.declaration, { opts = { desc = "LSP Declaration" } })
  map(
    "gd",
    "<cmd>Telescope lsp_definitions<cr>",
    { opts = { desc = "LSP Definition" }, has = "textDocument/definition" }
  )
  map("K", vim.lsp.buf.hover, { opts = { desc = "LSP Hover" } })
  map(
    "gK",
    vim.lsp.buf.signature_help,
    { opts = { desc = "LSP Signature Help" }, has = "textDocument/signatureHelp" }
  )
  map("gI", "<cmd>Telescope lsp_implementations<cr>", { opts = { desc = "LSP Implementation" } })
  map("gr", "<cmd>Telescope lsp_references<cr>", { opts = { desc = "LSP References" } })
  map("gy", "<cmd>Telescope lsp_type_definitions<cr>", { opts = { desc = "LSP Type Definition" } })
  map("<leader>ca", vim.lsp.buf.code_action, {
    mode = { "n", "v" },
    has = "textDocument/codeAction",
    opts = { desc = "LSP [C]ode [A]ctions" },
  })
  map(
    "<leader>rn",
    vim.lsp.buf.rename,
    { opts = { desc = "LSP [R]e[n]ame" }, has = "textDocument/rename" }
  )

  if client.supports_method("textDocument/documentHighlight") then
    local grp = aug("LSPDocumentHighlight." .. bufnr, {})

    au("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = grp,
      desc = "Highlight references under cursor",
    })

    au("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = grp,
      desc = "Clear Highlight references",
    })
  end

  if client.supports_method("textDocument/inlayHint") then
    local grp = aug("LSPInlayHints." .. bufnr, {})

    vim.defer_fn(function()
      local mode = vim.api.nvim_get_mode().mode
      vim.lsp.inlay_hint(bufnr, mode == "n" or mode == "v")
    end, 500)

    au("InsertEnter", {
      callback = function()
        vim.lsp.inlay_hint(bufnr, false)
      end,
      buffer = bufnr,
      group = grp,
      desc = "Disable inlay hints",
    })

    au("InsertLeave", {
      callback = function()
        vim.lsp.inlay_hint(bufnr, true)
      end,
      buffer = bufnr,
      group = grp,
      desc = "Enable inlay hints",
    })
  end

  if client.supports_method("textDocument/codeLens") then
    map("<leader>cl", vim.lsp.codelens.run, { opts = { desc = "LSP [C]ode [L]ens" } })
    local grp = aug("LSPCodeLens." .. bufnr, {})

    au("InsertEnter", {
      callback = function()
        vim.lsp.codelens.clear(nil, bufnr)
      end,
      buffer = bufnr,
      group = grp,
      desc = "Disable code lens",
    })

    au({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
      group = grp,
      desc = "Refresh code lens",
    })

    vim.lsp.codelens.refresh()
  end

  if client.name == "gopls" and not client.supports_method("textDocument/semanticTokens") then
    -- adding gopls semantic token support
    local semantic = client.config.capabilities.textDocument.semanticTokens
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
      range = true,
    }
  end

  if client.name == "ruff_lsp" then
    -- disable hover in favor of pyright
    client.server_capabilities.hoverProvider = false
  end
end

M.setup = function(server, opts)
  require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }, opts or {}))
end

return M
