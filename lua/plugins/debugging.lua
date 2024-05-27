return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        'rcarriga/nvim-dap-ui',
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')

        dap.adapters.php = {
            type = 'executable',
            command = 'node',
            args = {vim.fn.expand(vim.env.DBG_ADAPTER_PATH)},
        }

        dap.configurations.php = {
            {
                type = 'php',
                request = 'launch',
                name = 'Listen for xdebug',
                port = '9003',
                log = false,
                serverSourceRoot = vim.env.DBG_SERVER_PATH,
                localSourceRoot = vim.env.DBG_LOCAL_PATH,
            },
        }

        dapui.setup();

        vim.keymap.set('n', '<F7>', dap.step_out, {})
        vim.keymap.set('n', '<F8>', dap.continue, {})
        vim.keymap.set('n', '<F9>', dap.step_over, {})
        vim.keymap.set('n', '<F10>', dap.step_into, {})
        vim.keymap.set('n', '<F12>', dap.toggle_breakpoint, {})
        vim.keymap.set('n', '<leader>du', dapui.toggle, {})
    end,
}
