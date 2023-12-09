-- space as leader
vim.g.mapleader = ' '

-- lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
    -- colorscheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    -- tpope
    {"tpope/vim-dispatch"},
    {"tpope/vim-vinegar"},

    -- fzf
    {"junegunn/fzf"},
    {"junegunn/fzf.vim"},

    -- copilot
    {"github/copilot.vim"},

    -- lsp/completion
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-cmdline"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/nvim-cmp"},

    -- yanky
    {
      "gbprod/yanky.nvim",
      opts = {}
    },

    -- misc
    {"Lokaltog/vim-powerline"},

    -- phpactor
    {"gbprod/phpactor.nvim"},
});

-- colorscheme
vim.cmd[[colorscheme tokyonight]]

-- disable old-vim compatibility
vim.opt.compatible = false

-- always show sign column
vim.opt.signcolumn = 'yes'

-- show line numbers
vim.opt.number = true

-- enable smartcase when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- disable line wrapping
vim.opt.wrap = false

-- 4 spaces for tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- read file changes automatically
vim.opt.autoread = true

-- allow hidden buffers to go to background
vim.opt.hidden = true

-- keep cursor centered
vim.opt.scrolloff = 999

-- no backup files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- no newlines at end of files
vim.opt.fixendofline = false

-- open splits to the right/below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ctrl-space for newline
vim.keymap.set('i', '<C-space>', '<cr>');

-- navigate buffers
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Reselect visual block after indent/outdent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- clear search highlighting
vim.keymap.set('n', '<C-\\>', ':nohlsearch<CR>')

-- rename work under cursor
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/')

-- close all buffers
vim.api.nvim_create_user_command('BD', '%bd', {})

-- open lua config file
vim.api.nvim_create_user_command('Conf', 'e ~/.config/nvim/init.lua', {})

-- fzf
vim.keymap.set('n', '<C-p>', ':GFiles --others --cached --exclude-standard<CR>');
vim.g.fzf_history_dir = '~/.config/fzf/fzf-history'

-- neovide
vim.o.guifont = "Monaco:h12"
vim.g.neovide_cursor_animation_length = 0
-- workaround neovide copy/paste
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

-- yanky
vim.api.nvim_create_user_command('Yh', ':YankyRingHistory', {})

-- autocompletions
vim.cmd("autocmd BufEnter,BufNew *.php iabbrev ro readonly")
vim.cmd("autocmd BufEnter,BufNew *.php iabbrev psf public static function(): void<cr>{<cr>}<Up><Up><esc>f(i")
vim.cmd("autocmd BufEnter,BufNew *.php iabbrev pf public function(): void<cr>{<cr>}<Up><Up><esc>f(i")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tas self::assertSame")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tae self::assertEquals")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tac self::assertCount")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tan self::assertNull")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tann self::assertNotNull")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tee $this->expectException(\\Exception::class);<cr>$this->expectExceptionMessage('');")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev crg /** @return \\Generator<array-key, array{}> */<esc>0f{a")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev cdp /** @dataProvider*/<Left><Left>")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tpr $this->prophesize")
vim.cmd("autocmd BufEnter,BufNew *Test.php iabbrev tprr $this->prophesize(::class)->reveal()<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>")

-- vim-dispatch preview window
vim.g.dispatch_quickfix_height = 20

-- phpunit/phpspec
-- C-T to run the current test/spec
vim.cmd("autocmd BufEnter,BufNew *Test.php nnoremap <buffer> <C-t> :Dispatch docker compose exec bindhq-fpm rm -rf var/cache/test/twig ; docker compose exec bindhq-fpm php -d memory_limit=-1 vendor/bin/phpunit --colors=never --order-by default %<CR>")
vim.cmd("autocmd BufEnter,BufNew *Spec.php nnoremap <buffer> <C-t> :Dispatch docker compose exec bindhq-fpm vendor/bin/phpspec run %<CR>")
-- S-T on a test/spec name to run it individually
vim.cmd("autocmd BufEnter,BufNew *Test.php nnoremap <S-T> :Dispatch docker compose exec bindhq-fpm rm -rf var/cache/test/twig ; docker compose exec bindhq-fpm php -d memory_limit=-1 vendor/bin/phpunit --colors=never --order-by default --filter=<cword> %<CR>")
vim.cmd("autocmd BufEnter,BufNew *Spec.php nnoremap <S-T> :execute 'Dispatch docker compose exec bindhq-fpm vendor/bin/phpspec run %:' . line('.')<CR>")

require("phpactor").setup({
    install = { bin = vim.fn.expand('$HOME/bin/phpactor') }
})

vim.keymap.set('n', '<leader>nn', function()
    require('phpactor').rpc('navigate', {})
end)

-- lsp configuration
require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    init_options = {}
}

-- completion
local cmp = require'cmp'

cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
      ['<C-enter>'] = cmp.mapping.complete(),
      ['<C-space>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
})
