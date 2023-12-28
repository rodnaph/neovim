local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            },
        },
    },
})

-- ctrl-p to search git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- leader fu to find usages
vim.keymap.set('n', '<leader>fu', builtin.lsp_references, {})

-- leader bu to search buffers
vim.keymap.set('n', '<leader>bu', builtin.buffers, {})

-- leader of to previously opened files
vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})

-- leader ch to search command history
vim.keymap.set('n', '<leader>ch', builtin.command_history, {})

-- leader sh to search search history
vim.keymap.set('n', '<leader>sh', builtin.search_history, {})

-- ctrl-g to search word under cursor
vim.keymap.set('n', '<C-g>', builtin.grep_string, {})
