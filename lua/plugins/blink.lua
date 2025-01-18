return {
  'saghen/blink.cmp',
  dependencies = {
      'rafamadriz/friendly-snippets',
  },
  version = '*',
  opts = {
    keymap = { 
        ['<C-y>'] = { 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-space>'] = { 'accept', 'fallback' },
        ['<C-enter>'] = { 'show', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    
    signature = { enabled = true },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
      documentation = {
        auto_show = true,
      },
    },
  },
  opts_extend = { "sources.default" }
}
