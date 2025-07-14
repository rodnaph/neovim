return {    
    'tpope/vim-dispatch',
    config = function ()
        -- set height of dispatch window
        vim.g.dispatch_quickfix_height = 20

        -- C-T to run the current test/spec
        vim.cmd('autocmd BufEnter,BufNew *Test.php nnoremap <buffer> <C-t> :Dispatch rm -rf var/cache/test/twig ; php -d memory_limit=-1 vendor/bin/phpunit --colors=never --order-by default %<CR>')

        -- S-T on a test/spec name to run it individually
        vim.cmd('autocmd BufEnter,BufNew *Test.php nnoremap <S-T> :Dispatch rm -rf var/cache/test/twig ; php -d memory_limit=-1 vendor/bin/phpunit --colors=never --order-by default --filter=<cword> %<CR>')
        vim.cmd('autocmd BufEnter,BufNew *Spec.php nnoremap <S-T> :execute \'Dispatch vendor/bin/phpspec run %:\' . line(\'.\')<CR>')

        -- run php-cs-fixer on current file
        vim.api.nvim_create_user_command('Cs', function ()
            vim.cmd('Dispatch php vendor/bin/mago fmt ' .. vim.fn.expand('%'))
            vim.cmd('e')
        end, {})

        -- clear Symfony cache locally and in container
        vim.api.nvim_create_user_command('Cc', function ()
            vim.cmd('Dispatch rm -rf var/cache')
        end, {})
    end
}
