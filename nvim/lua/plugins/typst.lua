return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tinymist = {
        settings = {
          formatterMode = "typstyle", -- or "typstfmt"
          exportPdf = "onType", -- "onSave" also works
          semanticTokens = "disable",
        },
      },
    },
  },
}
