return {
    'almo7aya/openingh.nvim',
    config = function ()
        vim.api.nvim_set_keymap('n', '<Leader>gh', ':OpenInGHFileLines <CR>', { silent = true, noremap = true })
    end
}
