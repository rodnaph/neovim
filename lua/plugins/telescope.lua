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
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })

        telescope.load_extension('fzf')
        telescope.load_extension('yank_history')

        -- git files
        vim.keymap.set('n', '<C-p>', function ()
            builtin.git_files({ show_untracked = true })
        end)

        -- find usages
        vim.keymap.set('n', '<leader>fu', function ()
            builtin.lsp_references({ show_line = false })
        end)

        -- search buffers
        vim.keymap.set('n', '<leader>bu', function ()
            builtin.buffers();
        end)

        -- search file content
        vim.keymap.set('n', '<leader>ff', builtin.live_grep)

        -- previously opened files
        vim.keymap.set('n', '<leader>of', builtin.oldfiles)

        -- search word under cursor
        vim.keymap.set('n', '<C-g>', builtin.grep_string)

        -- search all files containing string
        vim.api.nvim_create_user_command('Find', function (opts)
            builtin.grep_string({ search = opts.args })
        end, { nargs = 1 });

        -- yank history
        vim.keymap.set('n', '<leader>yr', function ()
            telescope.extensions.yank_history.yank_history()
        end)

        -- by file type
        vim.keymap.set('n', '<leader>ft', function ()
            local file_extension = vim.fn.input("Enter file extension: ")
            builtin.find_files({
                file_ignore_patterns = { "%.git/", "node_modules/", "vendor/" },
                find_command = { "rg", "--files", "--iglob", "*." .. file_extension }
            })
        end)

        vim.keymap.set("n", "<leader>gs", function()
            builtin.git_status({
            })
        end)
    end
}
