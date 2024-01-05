return {
    'gbprod/phpactor.nvim',
    config = function ()
        require('phpactor').setup({
            install = { bin = vim.fn.expand('$HOME/bin/phpactor') }
        })

        vim.keymap.set('n', '<leader>nn', function()
            require('phpactor').rpc('navigate', {})
        end, { desc = 'Navigate to a related file.' })

        vim.keymap.set('n', '<leader>tt', function()
            require('phpactor').rpc('transform', {})
        end, { desc = 'Transform the current class.' })

        vim.keymap.set('n', '<leader>u', function()
            require('phpactor').rpc('import_class', {})
        end, { desc = 'Import the class under the cursor.' })
    end
}
