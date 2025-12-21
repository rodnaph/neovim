return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = 'v2.15.0',
    config = function ()
        require('oil').setup({
            keymaps = {
                ['<CR>'] = 'actions.select',
                ['-'] = 'actions.parent',
            },
            use_default_keymaps = false,
            skip_confirm_for_simple_edits = true,
            watch_for_changes = true,
            view_options = {
                is_always_hidden = function(name)
                    return '..' == name or name == '.git'
                end,
                show_hidden = true,
            }
        })

        vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end
}
