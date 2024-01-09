return {
    'gbprod/phpactor.nvim',
    tag = 'v1.0.1',
    config = function ()
        local phpactor = require('phpactor')

        phpactor.setup({
            install = { bin = vim.fn.expand('$HOME/bin/phpactor') }
        })

        vim.keymap.set('n', '<leader>nn', function()
            phpactor.rpc('navigate', {})
        end, { desc = 'Navigate to a related file.' })

        vim.keymap.set('n', '<leader>tt', function()
            phpactor.rpc('transform', {})
        end, { desc = 'Transform the current class.' })

        vim.keymap.set('n', '<leader>u', function()
            phpactor.rpc('import_class', {})
        end, { desc = 'Import the class under the cursor.' })
    end
}
