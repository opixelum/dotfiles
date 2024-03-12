return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        -- Show hidden files
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          show_hidden_count = false,
        },
      },
    },
  },
  {
    "okuuva/auto-save.nvim",
    opts = {
      -- Hide message when file is auto saved
      execution_message = {
        enabled = false,
      },
    },
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      vim.cmd("colorscheme github_dark_default")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, _)
      local cmp = require("cmp")
      cmp.setup({
        -- Use <TAB> to confirm completion
        mapping = {
          ["<TAB>"] = cmp.mapping.confirm({ select = true }),
        },
        -- Disable completion for text
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
            end,
          },
        }),
      })
    end,
  },
}
