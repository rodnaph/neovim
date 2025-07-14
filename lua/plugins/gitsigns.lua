return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            numhl = true,
            on_attach = function(bufnr)
              local gitsigns = require('gitsigns')

              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end

              map('n', '<leader>gb', function()
                gitsigns.blame({})
              end)
            end
        })
    end
}
