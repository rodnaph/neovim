return {
    'neovim/nvim-lspconfig',
    tag = 'v1.3.0',
    config = function ()
        local lspconfig = require('lspconfig')
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        lspconfig.intelephense.setup({
            capabilities = capabilities,
            init_options = {
                licenceKey = os.getenv('HOME') .. '/.config/intelephense/licence.key',
            },
            settings = {
                intelephense = {
                    files = {
                        exclude = {
                            "**/node_modules/**",
                            "**/var/**",
                        },
                    },
                },
            },
        })

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"},
                    },
                },
            },
        })

        lspconfig.cssls.setup({
            capabilities = capabilities,
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

                vim.keymap.set('n', '<leader>o', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts);
                vim.keymap.set('n', '<leader>r', function()
                    -- when rename opens the prompt, this autocommand will trigger
                    -- it will 'press' CTRL-F to enter the command-line window `:h cmdwin`
                    local cmdId
                    cmdId = vim.api.nvim_create_autocmd({ 'CmdlineEnter' }, {
                        callback = function()
                            local key = vim.api.nvim_replace_termcodes('<C-f>', true, false, true)
                            vim.api.nvim_feedkeys(key, 'c', false)
                            vim.api.nvim_feedkeys('0', 'n', false)
                            -- autocmd was triggered and so we can remove the ID and return true to delete the autocmd
                            cmdId = nil
                            return true
                        end,
                    })

                    vim.lsp.buf.rename()

                    -- if LSP couldn't trigger rename on the symbol, clear the autocmd
                    vim.defer_fn(function()
                        -- the cmdId is not nil only if the LSP failed to rename
                        if cmdId then
                            vim.api.nvim_del_autocmd(cmdId)
                        end
                    end, 500)
                end, opts)
            end,
        })
    end
}
