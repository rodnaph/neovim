return {
    'zbirenbaum/copilot.lua',
    enabled = false,
    config = function ()
        require('copilot').setup({
            panel = {
                auto_refresh = false,
            },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = '<C-y>',
                    accept_word = '<C-w>',
                },
            },
        })
    end
}
