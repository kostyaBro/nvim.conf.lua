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

        -- Automatically set up configuration after cloning packer.nvim.
        if packer_bootstrap then
            require('packer').sync()
        end
    end
)

