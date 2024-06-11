return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require('lualine').setup({
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'diagnostics'},
                lualine_c = {
                    {
                        'filetype',
                        icon_only = true,
                    },
                    {
                        'filename',
                        path = 1, -- relative path
                    },
                },
                lualine_x = {},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            }
        })
    end
}
