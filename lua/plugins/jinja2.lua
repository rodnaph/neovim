return {
    'Glench/Vim-Jinja2-Syntax',
    config = function ()
        -- use jinja2 syntax for html.twig files
        vim.cmd('autocmd BufNewFile,BufRead *.html.twig set ft=jinja')
        vim.cmd('autocmd BufNewFile,BufRead *.xml.twig set ft=jinja')
    end
}
