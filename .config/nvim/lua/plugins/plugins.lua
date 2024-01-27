return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          show_hidden_count = false,
        },
      },
    },
  },
  { "okuuva/auto-save.nvim", opts = {
    execution_message = {
      enabled = false,
    },
  } },
  { "projekt0n/github-nvim-theme" },
}
