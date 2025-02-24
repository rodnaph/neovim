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
    change_detection = {
        enabled = false
    },
    rocks = {
        enabled = false,
    },
    spec = {
        import = 'plugins',
    }
})
require('user.commands')
require('user.options')
require('user.keymap')
require('user.neovide')
