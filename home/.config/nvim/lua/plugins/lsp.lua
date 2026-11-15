return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      })
      vim.lsp.enable("rust_analyzer")

      -- Inlay hints and built-in completion when an LSP client attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end
          if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
          end
        end,
      })

      -- Format Rust files on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })
    end,
  },
}
