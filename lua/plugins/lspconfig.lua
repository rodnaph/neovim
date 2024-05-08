return {
    'neovim/nvim-lspconfig',
    tag = 'v0.1.7',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
    },
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

        -- completion
        local cmp = require('cmp')

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
              ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
              ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
              ['<C-enter>'] = cmp.mapping.complete(),
              ['<C-space>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
            }, {
              { name = 'buffer' },
            })
        })

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            local opts = { buffer = ev.buf }
            -- go to definition
            vim.keymap.set('n', '<leader>o', vim.lsp.buf.definition, opts)
            -- rename
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            -- hover
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          end,
        })
    end
}
