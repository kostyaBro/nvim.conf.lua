-- install packer, plugin manager
-- local fn = vim.fn
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--   vim.cmd [[packadd packer.nvim]]
-- end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(
    function(use)
        -- Manage packer using packer.
        use ('wbthomason/packer.nvim')

        -- Themes.
        use ('morhetz/gruvbox')
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        -- Fussy finder.
        -- Run ':checkhealth telescope' to see if telescope is installed correctly.
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        -- Copilot. AI model used to help you write code.
        use ('github/copilot.vim')

        -- Highlight.
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }

        -- Stage manager.
        use('theprimeagen/harpoon')

        -- Undotree.
        use('mbbill/undotree')

        -- LSP.
        use {
          'VonHeikemen/lsp-zero.nvim',
          requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
          }
        }

        -- Git. https://www.chrisatmachine.com/blog/category/neovim/12-git-integration
        use 'mhinz/vim-signify'
        use 'tpope/vim-fugitive'
        use 'junegunn/gv.vim' -- write :GV
        -- use 'lewis6991/gitsigns.nvim' -- useful but need to set up

        -- OLD plugins.
        -- Golang. 
        -- use 'fatih/vim-go' // TODO: think about using this plugin.

        -- use {
        --     'neoclide/coc.nvim',
        --     branch = 'master',
        --     run = 'yarn install --frozen-lockfile',
        -- }

        -- use {
        --   'kyazdani42/nvim-tree.lua',
        --   requires = {
        --         -- 'kyazdani42/nvim-web-devicons', -- optional, for file icons
        --     -- },
        --     -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
        --   }
        -- }

        -- Automatically set up configuration after cloning packer.nvim.
        if packer_bootstrap then
            require('packer').sync()
            vim.api.nvim_command('GoInstallBinaries')
        end
    end
)

