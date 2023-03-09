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

    -- Compile plugins when plugins.lua is saved
    vim.cmd([[
        augroup packer_user_config
	    autocmd!
	    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
    ]])
end)
