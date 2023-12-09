require('phpactor').setup({
    install = { bin = vim.fn.expand('$HOME/bin/phpactor') }
})

vim.keymap.set('n', '<leader>nn', function()
    require('phpactor').rpc('navigate', {})
end)

vim.keymap.set('n', '<leader>tt', function()
    require('phpactor').rpc('transform', {})
end)

vim.keymap.set('n', '<leader>u', function()
    require('phpactor').rpc('import_class', {})
end)
