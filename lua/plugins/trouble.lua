return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>ss",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "[S]how [S]ymbols via LSP",
    },
    {
      "<leader>sr",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "[S]how [R]references via LSP",
    },
  },
}
