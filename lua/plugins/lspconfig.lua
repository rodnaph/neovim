return {
    'neovim/nvim-lspconfig',
    tag = 'v0.1.7',
    config = function ()
        local lspconfig = require('lspconfig')
        local cwd = vim.fn.getcwd()

        lspconfig.intelephense.setup({
            settings = {
                intelephense = {
                    environment = {
                        includePaths = {
                            cwd .. "/src/",
                            cwd .. "/tests/",
                            cwd .. "/vendor/",
                        }
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
