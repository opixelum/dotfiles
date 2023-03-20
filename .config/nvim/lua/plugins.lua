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
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    -- Compile plugins when plugins.lua is saved
    vim.cmd([[
        augroup packer_user_config
	    autocmd!
	    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
    ]])
end)
