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

-- close all but current buffer
vim.keymap.set('n', '<C-u>', ':only<CR>')
