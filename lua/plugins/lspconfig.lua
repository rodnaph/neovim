return {
    'neovim/nvim-lspconfig',
    tag = 'v1.0.0',
    config = function ()
        local lspconfig = require('lspconfig')

        lspconfig.intelephense.setup({
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
    end
}
