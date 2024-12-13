-- close all buffers
vim.api.nvim_create_user_command('BD', '%bd', {})

-- open lua config file
vim.api.nvim_create_user_command('Conf', 'e ~/.config/nvim/init.lua', {})

-- autocompletions
vim.cmd('autocmd BufEnter,BufNew *.php iabbrev ro readonly')
vim.cmd('autocmd BufEnter,BufNew *.php iabbrev psf public static function(): iterable<cr>{<cr>}<Up><Up><esc>f(i')
vim.cmd('autocmd BufEnter,BufNew *.php iabbrev pf public function(): void<cr>{<cr>}<Up><Up><esc>f(i')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tas self::assertSame')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tae self::assertEquals')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tac self::assertCount')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tan self::assertNull')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tann self::assertNotNull')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tee $this->expectException(\\Exception::class);<cr>$this->expectExceptionMessage(\'\');')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev crg /** @return \\Generator<array-key, array{}> */<esc>0f{a')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev cdp /** @dataProvider*/<Left><Left>')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tpr $this->prophesize')
vim.cmd('autocmd BufEnter,BufNew *Test.php iabbrev tprr $this->prophesize(::class)->reveal()<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>')
