return {    
    'tpope/vim-dispatch',
    config = function ()
        -- set height of dispatch window
        vim.g.dispatch_quickfix_height = 20

        -- run phpunit for a given file path
        local function run_phpunit_for_file(path)
            vim.cmd('Dispatch rm -rf var/cache/test/twig ; php -d memory_limit=-1 vendor/bin/phpunit --colors=never --order-by default ' .. path)
        end

        -- resolve the test file for a source file using phpactor
        local function resolve_test_file(filepath)
            local cmd = string.format(
                'echo \'{"action":"navigate","parameters":{"source_path":"%s","destination":"unit_test"}}\' | %s/bin/phpactor rpc 2>/dev/null',
                filepath,
                vim.fn.expand('$HOME')
            )

            local result = vim.fn.system(cmd)
            local ok, decoded = pcall(vim.fn.json_decode, result)

            if ok and decoded and decoded.parameters and decoded.parameters.path then
                return decoded.parameters.path
            end

            vim.notify('Could not resolve test file for ' .. filepath, vim.log.levels.ERROR)
            return nil
        end

        function RunPHPUnitForTestFile()
            run_phpunit_for_file(vim.fn.expand('%'))
        end

        function RunPHPUnitForSourceFile()
            local test_file = resolve_test_file(vim.fn.expand('%:p'))
            if test_file then
                run_phpunit_for_file(test_file)
            end
        end

        -- C-T to run the test for the current file (works from both source and test files)
        vim.cmd([[autocmd BufEnter,BufNew */tests/*.php nnoremap <buffer> <C-t> :lua RunPHPUnitForTestFile()<CR>]])
        vim.cmd([[autocmd BufEnter,BufNew */src/*.php nnoremap <buffer> <C-t> :lua RunPHPUnitForSourceFile()<CR>]])

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
