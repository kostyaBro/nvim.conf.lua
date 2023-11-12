require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "vendor", -- golang
            "target", -- rust
            ".git",
        }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', function()
    builtin.grep_string({ search = vim.fn.input('Grep For > ') })
end)
vim.keymap.set('n', '<leader>flg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

