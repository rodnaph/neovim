vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticLineWarn',
    },
  },
})

vim.api.nvim_set_hl(0, 'DiagnosticLineError', { bg = '#3d2020' })
vim.api.nvim_set_hl(0, 'DiagnosticLineWarn', { bg = '#3d3520' }) 
