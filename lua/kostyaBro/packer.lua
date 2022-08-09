-- install packer, plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(
    function(use)
        -- Manage packer using packer.
        use 'wbthomason/packer.nvim'

        -- Themes.
        use 'morhetz/gruvbox'

        -- Tools.
        -- use 'lewis6991/gitsigns.nvim'

        -- Git. https://www.chrisatmachine.com/blog/category/neovim/12-git-integration
        use 'mhinz/vim-signify'
        use 'tpope/vim-fugitive'
        use 'tpope/vim-rhubarb'
        use 'junegunn/gv.vim'

        use {
            'neoclide/coc.nvim',
            branch = 'master',
            run = 'yarn install --frozen-lockfile',
        }

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        -- Golang.
        use 'fatih/vim-go'

        -- Automatically set up configuration after cloning packer.nvim.
        if packer_bootstrap then
            require('packer').sync()
            vim.api.nvim_command('GoInstallBinaries')
        end
    end
)

