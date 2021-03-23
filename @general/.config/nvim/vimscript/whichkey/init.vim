" Leader Key Maps

" By default timeoutlen is 1000 ms
" If set low to 100 vim surround wouldn't work
set timeoutlen=600

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Which Key Normal "<Space>" Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""

let g:which_key_map_leader = {}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map_leader[' '] = ['za', 'fold toggle']
let g:which_key_map_leader['r'] = [':FloatermNew ranger', 'ranger']
let g:which_key_map_leader['u'] = [':PackerUpdate', 'plugin update']
let g:which_key_map_leader['?'] = [':map', 'show-keybindings']
let g:which_key_map_leader['e'] = [':NvimTreeToggle', 'explorer']

let g:which_key_map_leader.c = {
    \ 'name' : '+close',
    \ 'w' : [':close', 'close window'],
    \ 'b' : [':bdelete', 'close buffer'],
    \ }

" F is for fold
let g:which_key_map_leader.F = {
    \ 'name': '+fold',
    \ 'O' : [':set foldlevel=20', 'open all'],
    \ 'C' : [':set foldlevel=0', 'close all'],
    \ 'c' : [':foldclose', 'close'],
    \ 'o' : [':foldopen', 'open'],
    \ '1' : [':set foldlevel=1', 'level1'],
    \ '2' : [':set foldlevel=2', 'level2'],
    \ '3' : [':set foldlevel=3', 'level3'],
    \ '4' : [':set foldlevel=4', 'level4'],
    \ '5' : [':set foldlevel=5', 'level5'],
    \ '6' : [':set foldlevel=6', 'level6']
    \ }

let g:which_key_map_leader.S = {
    \ 'name' : '+startify',
    \ 's' : [':SSave'        , 'save session'                 ],
    \ 'l' : [':SLoad'        , 'load session'                 ],
    \ 'd' : [':SDelete'      , 'delete session'               ],
    \ 'c' : [':SClose'       , 'close session'                ],
    \ 'h' : [':Startify'     , 'startify home'                ],
    \ }

let g:which_key_map_leader['g'] = {
    \ 'name': '+git',
    \ 'p': "go to prev hunk",
    \ 'n': "go to next hunk",
    \ 's': "stage hunk",
    \ 'u': "undo stage hunk",
    \ 'r': "reset hunk",
    \ 'R': "reset buffer",
    \ 'P': "preview hunk",
    \ 'b': "git blame line",
    \ 'B': [':Git blame', 'git blame buffer']
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Which Key "," Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""

let g:which_key_map_localleader = {}

" Map localleader to which_key
nnoremap <silent> <localleader> :silent <c-u> :silent WhichKey ','<CR>
vnoremap <silent> <localleader> :silent <c-u> :silent WhichKeyVisual ','<CR>

let g:which_key_map_localleader['.'] = [':lcd %:p:h', 'set working dir']
let g:which_key_map_localleader['b'] = [':split', 'horizontal split']
let g:which_key_map_localleader['v'] = [':vsplit', 'vertical split']
let g:which_key_map_localleader['c'] = [':let @+= expand("%")', 'copy current dir to clipboard']

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Register Which Key Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""

call which_key#register('<Space>', "g:which_key_map_leader")
call which_key#register(',', "g:which_key_map_localleader")