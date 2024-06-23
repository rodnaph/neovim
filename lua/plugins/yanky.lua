return {
    'gbprod/yanky.nvim',
    opts = {},
    config = function ()
        local actions = require('telescope.actions')
        local mapping = require("yanky.telescope.mapping")

        require('yanky').setup({
            picker = {
                telescope = {
                    use_default_mappings = false,
                    mappings = {
                        i = {
                            ['<cr>'] = mapping.put('p'),
                            ['p'] = mapping.put('p'),
                            ['P'] = mapping.put('P'),
                            ['<esc>'] = actions.close,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        },
                    }
                }
            }
        })
    end,
}
