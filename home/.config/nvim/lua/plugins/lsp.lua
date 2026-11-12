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

      -- Format Rust files on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })
    end,
  },
}
