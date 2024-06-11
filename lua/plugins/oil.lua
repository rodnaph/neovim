return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require('oil').setup({
            keymaps = {
                ['<CR>'] = 'actions.select',
                ['-'] = 'actions.parent',
            },
            use_default_keymaps = false,
            view_options = {
                is_always_hidden = function(name)
                    return '..' == name
                end,
                show_hidden = true,
            }
        })

        vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end
}
