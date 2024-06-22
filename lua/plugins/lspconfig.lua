return {
    'neovim/nvim-lspconfig',
    tag = 'v0.1.7',
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
    end
}
