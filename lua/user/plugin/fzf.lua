-- set history directory
vim.g.fzf_history_dir = '~/.config/fzf/fzf-history'

-- ctrl-p to search git files
vim.keymap.set('n', '<C-p>', ':GFiles --others --cached --exclude-standard<CR>');

-- C-g to search word under cursor
vim.keymap.set('n', '<C-g>', function ()
    vim.cmd('Rg ' .. vim.fn.expand('<cword>'))
end)
