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
        end)

        vim.keymap.set('n', '<leader>nu', function()
            rpc.call('navigate', {
                destination = 'unit_test',
                source_path = utils.path()
            })
        end)

        vim.keymap.set('n', '<leader>ns', function()
            rpc.call('navigate', {
                destination = 'source',
                source_path = utils.path()
            })
        end)

        vim.keymap.set('n', '<leader>tt', function()
            phpactor.rpc('transform', {})
        end)

        vim.keymap.set('n', '<leader>tn', function()
            rpc.call('transform', {
                transform = 'fix_namespace_class_name',
                source = utils.source(),
                path = utils.path(),
            })
        end)

        vim.keymap.set('n', '<leader>tc', function()
            rpc.call('transform', {
                transform = 'implement_contracts',
                source = utils.source(),
                path = utils.path(),
            })
        end)
    end
}
