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
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Search Git files.' })

-- leader fu to find usages
vim.keymap.set('n', '<leader>fu', function ()
    builtin.lsp_references({show_line = false})
end, { desc = 'Find usages via LSP.' })

-- leader bu to search buffers
vim.keymap.set('n', '<leader>bu', builtin.buffers, { desc = 'List open buffers.' })

-- leader of to previously opened files
vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'List old files.' })

-- leader ch to search command history
vim.keymap.set('n', '<leader>ch', builtin.command_history, { desc = 'List command history.' })

-- leader sh to search search history
vim.keymap.set('n', '<leader>sh', builtin.search_history, { desc = 'List search history.' })

-- ctrl-g to search word under cursor
vim.keymap.set('n', '<C-g>', builtin.grep_string, { desc = 'Search word under cursor.' })
