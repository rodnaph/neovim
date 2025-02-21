return {
    'gbprod/phpactor.nvim',
    tag = 'v1.0.1',
    config = function ()
        local phpactor = require('phpactor')
        local rpc = require('phpactor.rpc')
        local utils = require('phpactor.utils')

        phpactor.setup({
            install = { bin = vim.fn.expand('$HOME/bin/phpactor') },
            lspconfig = { enabled = false }
        })

        vim.keymap.set('n', '<leader>nn', function()
            phpactor.rpc('navigate', {})
        end, { desc = 'Navigate to a related file.' })

        vim.keymap.set('n', '<leader>nu', function()
            rpc.call('navigate', {
                destination = 'unit_test',
                source_path = utils.path()
            })
        end, { desc = 'Navigate to unit test.' })

        vim.keymap.set('n', '<leader>ns', function()
            rpc.call('navigate', {
                destination = 'source',
                source_path = utils.path()
            })
        end, { desc = 'Navigate to source.' })

        vim.keymap.set('n', '<leader>tt', function()
            phpactor.rpc('transform', {})
        end, { desc = 'Transform the current class.' })
    end
}
