require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    init_options = {}
}

-- completion
local cmp = require'cmp'

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
