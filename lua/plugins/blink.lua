return {
  'saghen/blink.cmp',
  dependencies = {
      'rafamadriz/friendly-snippets',
  },
  version = 'v1.4.1',
  opts = {
    keymap = { 
        ['<C-y>'] = { 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<tab>'] = { 'accept', 'fallback' },
        ['<C-space>'] = { 'accept', 'fallback' },
        ['<C-enter>'] = { 'show', 'fallback' },
    },

    cmdline = {
      enabled = true,
      keymap = {
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<tab>'] = { 'accept', 'fallback' },
      },
      completion = { menu = { auto_show = true } },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    
    signature = { enabled = true },

    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },

    completion = {
      accept = {
        dot_repeat = false,
      },
      documentation = {
        auto_show = true,
      },
    },
  },
  opts_extend = { "sources.default" }
}
