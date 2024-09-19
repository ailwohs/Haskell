require("config.lazy")

return {
    "mason.nvim",
    opts = { ensure_installed = { "html-lsp" } },
  }

  return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  }