-- colorscheme
vim.cmd[[colorscheme kanagawa]]

-- font
vim.o.guifont = 'Monaco:h12'

-- disable old-vim compatibility
vim.opt.compatible = false

-- always show sign column
vim.opt.signcolumn = 'yes'

-- sync os/neo clipboard
vim.opt.clipboard = 'unnamedplus'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- show line numbers
vim.opt.number = true

-- enable smartcase when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- disable line wrapping
vim.opt.wrap = false

-- 4 spaces for tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- read file changes automatically
vim.opt.autoread = true

-- allow hidden buffers to go to background
vim.opt.hidden = true

-- keep cursor centered
vim.opt.scrolloff = 999

-- no backup files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- no newlines at end of files
vim.opt.fixendofline = false

-- open splits to the right/below
vim.opt.splitbelow = true
vim.opt.splitright = true

