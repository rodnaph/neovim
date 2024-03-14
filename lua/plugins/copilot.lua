return {
    'zbirenbaum/copilot.lua',
    config = function ()
        require('copilot').setup({
            panel = {
                auto_refresh = false,
            },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = '<C-y>',
                },
            },
        })
    end
}
