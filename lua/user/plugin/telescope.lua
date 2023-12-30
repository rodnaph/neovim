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
    require('notify')("Finding usages via LSP...")
    builtin.lsp_references({show_line = false})
end, { desc = '[F]ind [U]sages via LSP.' })

-- leader bu to search buffers
vim.keymap.set('n', '<leader>bu', function ()
    builtin.buffers();
end, { desc = 'List open [BU]ffers.' })

-- leader of to previously opened files
vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'List [O]ld [F]iles.' })

-- leader ch to search command history
vim.keymap.set('n', '<leader>ch', builtin.command_history, { desc = 'List [C]ommand [H]istory.' })

-- leader sh to search search history
vim.keymap.set('n', '<leader>sh', builtin.search_history, { desc = 'List [S]earch [H]istory.' })

-- ctrl-g to search word under cursor
vim.keymap.set('n', '<C-g>', builtin.grep_string, { desc = 'Search word under cursor.' })
