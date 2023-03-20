local keyset = vim.keymap.set

return require("packer").startup(function(use)
    -- Packer
    use "wbthomason/packer.nvim"

    -- NvimTree
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
          "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup {}
            vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function()
                require("nvim-tree.api").tree.open()
            end })
        end
    }

    -- AutoSave
    use {
        "Pocco81/auto-save.nvim",
        config = function()
             require("auto-save").setup {}
        end
    }

    -- GitHub Theme
    use {
        "projekt0n/github-nvim-theme",
        config = function()
            require("github-theme").setup {
                theme_style = "dark_default"
            }
        end
    }

    -- COC
    use {'neoclide/coc.nvim', branch = 'release'}
    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
    keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
    keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
    keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
    keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
    keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
    keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

    -- Markdown Preview
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    local builtin = require('telescope.builtin')
    keyset('n', '<leader>ff', builtin.find_files, {})
    keyset('n', '<leader>fg', builtin.live_grep, {})
    keyset('n', '<leader>fb', builtin.buffers, {})
    keyset('n', '<leader>fh', builtin.help_tags, {})

    -- Compile plugins when plugins.lua is saved
    vim.cmd([[
        augroup packer_user_config
	    autocmd!
	    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
    ]])
end)
