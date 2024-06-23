return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
        'nvim-treesitter/nvim-treesitter',
        'sharkdp/fd',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function ()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-p>'] = actions.cycle_history_prev,
                        ['<C-n>'] = actions.cycle_history_next,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                }
            }
        })

        telescope.load_extension('fzf')
        telescope.load_extension('yank_history')

        -- ctrl-p to search git files
        vim.keymap.set('n', '<C-p>', function ()
            builtin.git_files({ show_untracked = true })
        end, { desc = 'Search Git files.' })

        -- leader fu to find usages
        vim.keymap.set('n', '<leader>fu', function ()
            builtin.lsp_references({ show_line = false })
        end, { desc = '[F]ind [U]sages via LSP.' })

        -- leader bu to search buffers
        vim.keymap.set('n', '<leader>bu', function ()
            builtin.buffers();
        end, { desc = 'List open [BU]ffers.' })

        -- leader ff to search files
        vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = '[Find] in [F]iles.' })

        -- leader of to previously opened files
        vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'List [O]ld [F]iles.' })

        -- leader ch to search command history
        vim.keymap.set('n', '<leader>ch', builtin.command_history, { desc = 'List [C]ommand [H]istory.' })

        -- leader sh to search search history
        vim.keymap.set('n', '<leader>sh', builtin.search_history, { desc = 'List [S]earch [H]istory.' })

        -- ctrl-g to search word under cursor
        vim.keymap.set('n', '<C-g>', builtin.grep_string, { desc = 'Search word under cursor.' })

        -- use Find to search all files containing string with Telescope
        vim.api.nvim_create_user_command('Find', function (opts)
            builtin.grep_string({ search = opts.args })
        end, { nargs = 1 });

        -- leader yr to search yank history
        vim.keymap.set('n', '<leader>yr', function ()
            telescope.extensions.yank_history.yank_history()
        end, { desc = 'List [Y]ank[R]ing history.' })
    end
}
