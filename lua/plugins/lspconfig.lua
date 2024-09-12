return {
    'neovim/nvim-lspconfig',
    tag = 'v1.0.0',
    config = function ()
        local lspconfig = require('lspconfig')

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
          properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
            'codeAction',
           }
        }

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
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"},
                    },
                },
            },
        })

        lspconfig.cssls.setup({
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

                vim.keymap.set('n', '<leader>o', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts);
            end,
        })
    end
}
