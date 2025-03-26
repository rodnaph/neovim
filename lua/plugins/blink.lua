return {
  'saghen/blink.cmp',
  dependencies = {
      'rafamadriz/friendly-snippets',
  },
  opts = {
    keymap = { 
        ['<C-y>'] = { 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<tab>'] = { 'accept', 'fallback' },
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

    fuzzy = {
      prebuilt_binaries = {
          force_version = "v0.14.0",
      }
    },

    completion = {
      documentation = {
        auto_show = true,
      },
    },
  },
  opts_extend = { "sources.default" }
}
