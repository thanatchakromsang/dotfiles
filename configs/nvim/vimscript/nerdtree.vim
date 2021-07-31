" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" NERDTree options
autocmd FileType nerdtree setlocal signcolumn=no

let NERDTreeDirArrows = 0
let NERDTreeWinPos = 'left'
let NERDTreeWinSize = 24
let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore = 1
let NERDTreeMinimalUI = 1

let g:webdevicons_enable_nerdtree = 1

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
