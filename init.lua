-- space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'rebelot/kanagawa.nvim',
    'tpope/vim-eunuch',
    'tpope/vim-dispatch',
    'tpope/vim-vinegar',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'nvim-treesitter/nvim-treesitter',
            'sharkdp/fd',
        }
    },
    'github/copilot.vim',
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            'hrsh7th/nvim-cmp',
        }
    },
    'gbprod/phpactor.nvim',
    'Lokaltog/vim-powerline',
    'amarakon/nvim-unfocused-cursor',
    'Glench/Vim-Jinja2-Syntax',
});

require('user.commands')
require('user.options')
require('user.keymap')
require('user.visual')

require('user.plugin.telescope')
require('user.plugin.neovide')
require('user.plugin.phpactor')
require('user.plugin.nvim-unfocused-cursor')
require('user.plugin.vim-dispatch')
require('user.plugin.vim-jinja2-syntax')
require('user.plugin.lsp')
