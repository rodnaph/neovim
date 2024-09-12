return {
    'gbprod/phpactor.nvim',
    tag = 'v1.0.1',
    config = function ()
        local phpactor = require('phpactor')

        phpactor.setup({
            install = { bin = vim.fn.expand('$HOME/bin/phpactor') },
            lspconfig = { enabled = false }
        })

        vim.keymap.set('n', '<leader>nn', function()
            phpactor.rpc('navigate', {})
        end, { desc = 'Navigate to a related file.' })

        vim.keymap.set('n', '<leader>tt', function()
            phpactor.rpc('transform', {})
        end, { desc = 'Transform the current class.' })
    end
}
