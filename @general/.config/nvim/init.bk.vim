"==============================="
" Author: Thanatchaya Kromsaeng "
"==============================="

" Setup Plug  ---------------------------------------------------------------{{{

  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
  \| endif

  call plug#begin('~/.config/nvim/plugged')

" Sensible {{{
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-abolish'
  Plug 'justinmk/vim-sneak'
  Plug 'sgur/vim-editorconfig'
  Plug 'mhinz/vim-startify'
  Plug 'voldikss/vim-floaterm'
  Plug 'liuchengxu/vim-which-key'
  Plug 'pedrohdz/vim-yaml-folds'
  Plug 'tpope/vim-vinegar'
" }}}

" Highlight {{{
  " XXX: Required nvim 0.5
  " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'sheerun/vim-polyglot'
" }}}

" COC {{{
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
	Plug 'junegunn/fzf', { 'do': './install --all'}
	Plug 'junegunn/fzf.vim', { 'do': 'g:fzf_install' }
	Plug 'airblade/vim-rooter'
  Plug 'liuchengxu/vista.vim'
  Plug 'honza/vim-snippets'
	let g:coc_global_extensions = [
				\		'coc-json',
				\		'coc-go',
				\		'coc-sh',
				\		'coc-python',
				\		'coc-solargraph',
				\		'coc-docker',
				\		'coc-snippets',
				\		'coc-yaml',
				\		'coc-tsserver',
				\		'coc-pairs',
				\		'coc-rust-analyzer',
				\		'coc-vimlsp',
				\		'coc-prettier'
				\	]
" }}}

" Fast Motion {{{
  Plug 'haya14busa/incsearch.vim'
  Plug 'unblevable/quick-scope'
" }}}

" Colorscheme {{{
  Plug 'morhetz/gruvbox'
" }}}

" Appearance {{{
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
" }}}

" Git {{{
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'
" }}}

" Linter {{{
  Plug 'w0rp/ale'
" }}}

" Misc plugin {{{
  Plug 'Konfekt/FastFold'
  Plug 'Shougo/context_filetype.vim'
  Plug 'mhinz/vim-sayonara'
" }}}

  " Initialize plugin system
  call plug#end()

" }}}

" System settings  ----------------------------------------------------------{{{

" Neovim Settings
  set encoding=utf-8

  if has('mouse')
    set mouse=a
  endif

  let uname = system('uname')

  if uname =~ 'Linux'
    if (has('nvim'))
      let g:python_host_prog = '/usr/bin/python2'
      let g:python3_host_prog = '/usr/bin/python3'
    endif
  elseif uname =~ 'Darwin'
    if (has('nvim'))
      let g:python_host_prog = '/usr/local/bin/python2.7'
      let g:python3_host_prog = '/usr/local/bin/python3.8'
    endif
  endif

" show results of substition as they're happening
" but don't open a split
  set inccommand=nosplit

" file type determines whether any plugins for scripts,
" indenting rules, or syntax highlighting are loaded
  filetype plugin indent on
  filetype plugin on

" enable syntax highlight
  syntax enable

" default config
  set tabstop=2 shiftwidth=2 expandtab softtabstop=2

  set scrolloff=999

" set case-insensitive search
  set ignorecase
  set smartcase

" yank to system clipboard
  set clipboard^=unnamed,unnamedplus
  set nopaste

" hidden no write since last change (add ! to override)
  set hidden
" automatic set title
  set title

" remove unwanted space
  autocmd BufWritePre * %s/\s\+$//e

" hide mode in statusline
  set noshowmode

" disable backup files
  set nobackup
	set nowritebackup
  set noswapfile

" set width of gutter
  set numberwidth=1

" disable syntax conceal
  set conceallevel=0

" commandline completion
  set wildmenu
  set wildignore+=*/tmp/*,*.so,*.swp,
        \*.zip,*.pyc,*.db,*.sqlite

" display incomplete commands
  set laststatus=2

" Give more space for displaying messages.
  set cmdheight=1

" word wrapping, but only line breaks inserted when explicitly press enter
  set wrap
  set linebreak
  set nolist

  set formatoptions+=t

" reload unchanged files automatically
  set autoread

" set update time for some plugins (default is 4000)
  set updatetime=300

" set 256color support
  set t_Co=256

" save undo info
  if !isdirectory($HOME."/.vim")
      call mkdir($HOME."/.vim", "", 0770)
  endif
  if !isdirectory($HOME."/.vim/undo-dir")
      call mkdir($HOME."/.vim/undo-dir", "", 0700)
  endif
  set undodir="$HOME/.vim/undo-dir"
  set undofile

" leader key
  nnoremap <SPACE> <Nop>
  let mapleader = " "
  let maplocalleader = ","

" remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif

" center buffer around cursor when opening files
  autocmd BufRead * normal zz

" .: Scan the current buffer
" w: Scan buffers from other windows
" b: Scan buffers from the buffer list
" u: Scan buffers that have been unloaded from the buffer list
" t: Tag completion
" i: Scan the current and included files
  set complete=.,w,b,u,t,i

" when enter insert mode change to current files dir
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" disable short messages
  set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
	if has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif

" recognize filename in vim
" default isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=
  set isfname+={,}

" set variable specific to a files
" eg. /* vim: tw=60 ts=2: */
  set modelines=10

" special character for tab, trail, eol etc..
  set listchars=tab:‣\ ,trail:·,precedes:«,extends:»,eol:¬
  set list

" fix backspace indent
  set backspace=indent,eol,start

" open new split panes to right and bottom, which feels more natural
  set splitright
  set splitbelow

" Silently execute an external command
" No 'Press Any Key to Contiue BS'
" from: http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
  command! -nargs=1 SilentCmd
  \ | execute ':silent !'.<q-args>
  \ | execute ':redraw!'

" }}}

" System mappings  ----------------------------------------------------------{{{

" no one is really happy until you have this shortcuts
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall

" command history
  nnoremap q: <nop>
  nnoremap q/ <nop>
  nnoremap q? <nop>
  " nnoremap Q: q:
  " nnoremap Q/ q/
  " nnoremap Q? q?

" no need for ex mode
  nnoremap Q <nop>
  vnoremap // y/<C-R>"<CR>

" split
  noremap <localleader>b :<C-u>split<CR>
  noremap <localleader>v :<C-u>vsplit<CR>

" Set working directory
  nnoremap <localleader>. :lcd %:p:h<CR>

" copy current files path to clipboard
  nnoremap <localleader>cp :let @+= expand("%") <cr>

" Navigate between display lines
  nnoremap <silent><expr> k      v:count == 0 ? 'gk' : 'k'
  nnoremap <silent><expr> j      v:count == 0 ? 'gj' : 'j'
  nnoremap <silent><expr> <Up>   v:count == 0 ? 'gk' : 'k'
  nnoremap <silent><expr> <Down> v:count == 0 ? 'gj' : 'j'
" PageUp PageDown to move up/down 5 lines
	map <silent> <PageUp> 5<C-U>
	map <silent> <PageDown> 5<C-D>

" Move around 'normal mode'
  noremap H ^
  noremap L $

" Move visual block 'visual mode'
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

" Align blocks of text and keep them selected
  vmap < <gv
	vmap > >gv
  nnoremap <silent> <esc> :noh<cr>

" Switching windows
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l
  noremap <C-h> <C-w>h

  inoremap <c-f> <c-x><c-f>

" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>
  " vnoremap y "*y<CR>
  noremap Y y$
  vnoremap y myy`y
  vnoremap Y myY`y
  noremap YY "+yy<CR>

" Override default behavior where vim will replace default register with copy
" from pasted
  xnoremap p pgvy

" Navigate buffer
  noremap <S-Tab> :bp<CR>
  noremap <Tab> :bn<CR>

" Incsearch
  let g:incsearch#auto_nohlsearch = 1
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)

" " disable Arrow keys in Escape mode
"   map <up> <nop>
"   map <down> <nop>
"   map <left> <nop>
"   map <right> <nop>

" " disable Arrow keys in Insert mode
"   imap <up> <nop>
"   imap <down> <nop>
"   imap <left> <nop>
"   imap <right> <nop>

  map f <Plug>Sneak_f
  map F <Plug>Sneak_F
  map t <Plug>Sneak_t
  map T <Plug>Sneak_T

"}}}"

" Appearance settings  ------------------------------------------------------{{{

" show the cursor position all the time
  set ruler
  set cursorline
  set relativenumber
  set number
  set fillchars=""

  " IndentLine  ----------------------------------------------------------{{{

    let g:indentLine_enabled = 1
    let g:indentLine_color_term = 239
    let g:indentLine_concealcursor = 'inc'
    let g:indentLine_conceallevel = 2
    let g:indentLine_char = '│'
    let g:indentLine_leadingSpaceChar = '·'

  "}}}

  " Airline  -------------------------------------------------------------{{{

		call airline#parts#define_raw('linenr', '%l')
		call airline#parts#define_accent('linenr', 'bold')
		let g:airline_section_z = airline#section#create(['%3p%% ',
								\ g:airline_symbols.linenr .' ', 'linenr', ':%c'])
		let g:airline#extensions#coc#enabled = 1
    let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z' ]
      \ ]
    let g:webdevicons_enable_airline_statusline = 0
    let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ ''	 : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#buffer_idx_format = {
      \ '1': ' 1: ',
      \ '2': ' 2: ',
      \ '3': ' 3: ',
      \ '4': ' 4: ',
      \ '5': ' 5: ',
      \ '6': ' 6: ',
      \ '7': ' 7: ',
      \ '8': ' 8: ',
      \ '9': ' 9: ',
      \}

    set hidden
    let g:airline_theme = 'gruvbox'
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#branch#format = 0
    let g:airline_skip_empty_sections = 1
    let g:airline_detect_spelllang=0
    let g:airline#extensions#hunks#enabled = 0
    let g:airline#extensions#wordcount#enabled = 0
    let g:airline#extensions#whitespace#enabled = 0

    let g:webdevicons_enable_airline_statusline = 0
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline_powerline_fonts = 1
    let g:airline_symbols.readonly = ''

    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''

    let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
    let g:airline#extensions#readonly#symbol   = '⊘'
    " let g:airline#extensions#linecolumn#prefix = '¶'
    " let g:airline#extensions#paste#symbol      = 'ρ'

  "}}}

"}}}

" Themes  -------------------------------------------------------------------{{{

  colorscheme gruvbox
  set background=dark

    " wallpaper background color
    hi Normal ctermbg=NONE ctermfg=NONE

    " hi CursorLine ctermbg=236
    " hi StatusLine ctermbg=235

  " Custom ALE
    hi ALEErrorSign ctermbg=237
    hi ALEWarningSign ctermbg=237

   " Search
    hi Search cterm=bold,inverse


   " Sneak
    hi link Sneak Search

	 " QuickScope
		hi QuickScopePrimary cterm=bold,underline
		hi QuickScopeSecondary cterm=underline

  " WhichKey
    hi WhichKey ctermfg=214 ctermbg=NONE cterm=bold
    hi WhichKeySeperator ctermfg=102 ctermbg=NONE cterm=NONE
    hi WhichKeyGroup ctermfg=108 ctermbg=NONE cterm=NONE
    hi WhichKeyDesc ctermfg=208 ctermbg=NONE cterm=NONE
    hi WhichKeyFloating ctermfg=NONE ctermbg=239 cterm=NONE


"}}}

" FZF -----------------------------------------------------------------------{{{

	" This is the default extra key bindings
	let g:fzf_action = {
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-x': 'split',
		\ 'ctrl-v': 'vsplit' }

	" Enable per-command history.
	" CTRL-N and CTRL-P will be automatically bound to next-history and
	" previous-history instead of down and up. If you don't like the change,
	" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
	let g:fzf_history_dir = '~/.local/share/fzf-history'

	let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
	let $FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g '!{node_modules,.git}'"

	" Customize fzf colors to match your color scheme
	let g:fzf_colors =
	\ { 'fg':      ['fg', 'Normal'],
		\ 'bg':      ['bg', 'Normal'],
		\ 'hl':      ['fg', 'Comment'],
		\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
		\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
		\ 'hl+':     ['fg', 'Statement'],
		\ 'info':    ['fg', 'PreProc'],
		\ 'border':  ['fg', 'Normal'],
		\ 'prompt':  ['fg', 'Conditional'],
		\ 'pointer': ['fg', 'Exception'],
		\ 'marker':  ['fg', 'Keyword'],
		\ 'spinner': ['fg', 'Label'],
		\ 'header':  ['fg', 'Comment'] }

	"Get Files
	command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

	" Get text in files with Rg
	command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
		\   fzf#vim#with_preview(), <bang>0)

  function Rg_input()
      call inputsave()
      let name = input("Rg filter: ")
      exec ":Rg ".name
      call inputrestore()
  endfunction

	" Ripgrep advanced
	function! RipgrepFzf(query, fullscreen)
		let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
		let initial_command = printf(command_fmt, shellescape(a:query))
		let reload_command = printf(command_fmt, '{q}')
		let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
		call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
	endfunction

	command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  function RG_input()
      call inputsave()
      let name = input("RG filter: ")
      exec ":RG ".name
      call inputrestore()
  endfunction
"}}}

" Programing language settings  ---------------------------------------------{{{

	" Markdown settings  ------------------------------------------------------{{{

		let g:vim_markdown_conceal = 0
		let g:vim_markdown_conceal_code_blocks = 0

	"}}}

"}}}

" COC -----------------------------------------------------------------------{{{

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	let g:coc_snippet_next = '<tab>'

" <CR> auto-select the first completion
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" 	if exists('*complete_info')
" 		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" 	else
" 		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" 	endif

" Use <c-space> to trigger completion.
	if has('nvim')
		inoremap <silent><expr> <c-space> coc#refresh()
	else
		inoremap <silent><expr> <c-@> coc#refresh()
	endif

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocActionAsync('doHover')
		endif
	endfunction

" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold   :call CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gt <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gn <Plug>(coc-diagnostic-next)
  nmap <silent> gp <Plug>(coc-diagnostic-prev)

  " " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

"}}}

" Linting -------------------------------------------------------------------{{{

  let g:ale_set_highlights = 0
  let g:ale_sign_error = '●'
  let g:ale_sign_warning = '•'
  let g:ale_echo_msg_error_str = '[E]'
  let g:ale_echo_msg_warning_str = '[W]'

  let g:airline#extensions#ale#error_symbol='● '
  let g:airline#extensions#ale#warning_symbol='•  '
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 0

  let g:ale_fix_on_save = 1
  let g:ale_linters = {
        \ 'javascript': ['eslint'],
        \ 'typescript': ['tslint'],
        \ 'python': ['flake8'],
        \ 'css': ['stylelint'],
        \ }

  let g:ale_fixers = {
        \ 'javascript': ['eslint'],
        \ 'css': ['stylelint'],
        \ }

  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  " let g:ale_set_loclist = 0
  " let g:ale_set_quickfix = 1

"}}}

" Terminal settings  --------------------------------------------------------{{{

  " au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " autocmd BufEnter term://* startinsert
  autocmd TermOpen * set bufhidden=hide

" }}}

" Tmux  ---------------------------------------------------------------------{{{

"  let g:tmux_navigator_no_mappings = 1
"  " let g:tmux_navigator_save_on_switch = 2
"  let g:tmux_navigator_disable_when_zoomed = 1

"  nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
"  nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
"  nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
"  nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"  nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

"  tmap <C-h> <C-\><C-n>:TmuxNavigateDown<cr>
"  tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
"  tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
"  tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
"  tmap <C-\> <C-\><C-n>:TmuxNavigatePrevious<cr>

""}}}

" Fold function  ------------------------------------------------------------{{{

  function! MyFoldText() " {{{
      let line = getline(v:foldstart)
      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
      " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
      let fillcharcount = windowwidth - len(line)
      " return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
      return line . '⋯'. repeat(" ",fillcharcount)
  endfunction " }}}

  set foldtext=MyFoldText()

  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  " autocmd FileType vim setlocal fdc=1
  set foldlevel=99

  " Backspace to toggle folds.
  nnoremap <BS> za
  vnoremap <BS> za
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0

  autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99

  autocmd FileType css,scss,json setlocal foldmethod=marker
  autocmd FileType css,scss,json setlocal foldmarker={,}

  autocmd FileType coffee setl foldmethod=indent
  " let g:xml_syntax_folding = 1
  autocmd FileType xml setl foldmethod=syntax

  autocmd FileType html setl foldmethod=expr
  autocmd FileType html setl foldexpr=HTMLFolds()

  autocmd FileType javascript,typescript,typescriptreact,json setl foldmethod=syntax

  autocmd FileType graphql setl foldmethod=syntax

  autocmd FileType git setlocal foldmethod=syntax
  autocmd FileType git setlocal foldlevel=0

" }}}

" GitGutter -----------------------------------------------------------------{{{

  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_lines = 0

"}}}

" Startify ------------------------------------------------------------------{{{

	let g:startify_session_dir = '~/.config/nvim/session'
	let g:startify_lists = [
						\ { 'type': 'files',     'header': ['   Files']            },
						\ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
						\ { 'type': 'sessions',  'header': ['   Sessions']       },
						\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
						\ ]
	let g:startify_bookmarks = [
							\ { 'c': '~/.config/i3/config' },
							\ { 'i': '~/.config/nvim/init.vim' },
							\ { 'k': '~/.dotfiles/keyboards/users/thanatchaya/thanatchaya.h' },
							\ { 'z': '~/.zshrc' },
							\ '~/Developer',
							\ ]
"}}}

" Quick Scope ---------------------------------------------------------------{{{

	" " Trigger a highlight in the appropriate direction when pressing these keys:
	" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T', 's', 'S']

	let g:qs_max_chars=150

	let g:qs_buftype_blacklist = ['terminal', 'nofile']

"}}}

" Floaterm ------------------------------------------------------------------{{{

  " Configuration example
  let g:floaterm_keymap_new    = '<F7>'
  let g:floaterm_keymap_prev   = '<F8>'
  let g:floaterm_keymap_next   = '<F9>'
  let g:floaterm_keymap_toggle = '<F12>'

  " Floaterm
  let g:floaterm_autoinsert=1
  let g:floaterm_width=0.7
  let g:floaterm_height=0.7
  let g:floaterm_wintitle=0
  let g:floaterm_autoclose=1

"}}}

" WhichKey ------------------------------------------------------------------{{{

  " By default timeoutlen is 1000 ms
  set timeoutlen=2500

  " Register which key map
  call which_key#register('<Space>', "g:which_key_map_leader")
  nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
  vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>

  " Create map to add keys to
  let g:which_key_map_leader = {}
  " Define a separator
  let g:which_key_sep = '→'

  " Not a fan of floating windows for this
  let g:which_key_use_floating_win = 0

  " Hide status line
  autocmd! FileType which_key
  autocmd  FileType which_key set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

  let g:which_key_map_leader['u'] = [ ':PlugUpdate'        ,  'vim-plug update'       ]
  let g:which_key_map_leader['r'] = [ ':call Rg_input()'   ,  'text ripgrep'          ]
  let g:which_key_map_leader['R'] = [ ':call RG_input()'   ,  'text advanced ripgrep' ]
  let g:which_key_map_leader['c'] = [ ':close'             ,  'close floatint window' ]
  let g:which_key_map_leader['f'] = [ ':Files'             ,  'search files'          ]
  let g:which_key_map_leader['?'] = [ ':Maps'              ,  'show-keybindings'      ]
  let g:which_key_map_leader[' '] = [ 'za'                 ,  'fold toggle'           ]
  let g:which_key_map_leader['d'] = [ 'bd'                 ,  'delete-buffer'         ]

" s is for search
  let g:which_key_map_leader['s'] = {
      \ 'name' : '+search',
      \ '/' : [':History/'              , 'history'             ],
      \ ';' : [':Commands'              , 'commands'            ],
      \ 'b' : [':BLines'                , 'current buffer'      ],
      \ 'B' : [':Buffers'               , 'open buffers'        ],
      \ 'c' : [':Commits'               , 'commits'             ],
      \ 'C' : [':BCommits'              , 'current file commits'],
      \ 's' : [':Vista finder'          , 'symbol fzf search'   ],
      \ 'd' : [':CocFzfList diagnostics', 'diagnostic list'     ],
      \ 'f' : [':Files'                 , 'files'               ],
      \ 'g' : [':GFiles'                , 'git files'           ],
      \ 'h' : [':History'               , 'file history'        ],
      \ 'H' : [':History:'              , 'command history'     ],
      \ 'l' : [':Lines'                 , 'lines'               ],
      \ 'm' : [':Marks'                 , 'marks'               ],
      \ 'M' : [':Maps'                  , 'normal maps'         ],
      \ 't' : [':call Rg_input()'       , 'text ripgrep'        ],
      \ 'w' : [':Windows'               , 'search windows'      ],
      \ }

  let g:which_key_map_leader['S'] = {
      \ 'name' : '+startify',
      \ 's' : [':SSave'        , 'save session'                 ],
      \ 'l' : [':SLoad'        , 'load session'                 ],
      \ 'd' : [':SDelete'      , 'delete session'               ],
      \ 'c' : [':SClose'       , 'close session'                ],
      \ 'h' : [':Startify'     , 'home (startify)'              ],
      \ }

  let g:which_key_map_leader['t'] = {
      \ 'name' : '+terminal' ,
      \ 't' : [':FloatermToggle'               , 'toggle'    ],
      \ 'h' : [':FloatermNew htop'             , 'htop'      ],
      \ 'd' : [':FloatermNew lazydocker'       , 'lazydocker'],
      \ 'g' : [':FloatermNew lazygit'          , 'lazygit'   ],
      \ 'r' : [':FloatermNew ranger'           , 'ranger'    ],
      \ }

 let g:which_key_map_leader['l'] = {
      \ 'name' : '+lsp',
      \ 'd' : [':CocFzfList diagnostics'       , 'diagnostic list'   ],
      \ 'f' : [':Format'                       , 'formatting'        ],
      \ 'o' : [':OR'                           , 'organize import'   ],
      \ 'r' : ['<Plug>(coc-rename)'            , 'rename'            ],
      \ 's' : [':Vista finder'                 , 'symbol fzf search' ],
      \ 't' : [':Vista!!'                      , 'symbol view toggle'],
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : ['<Plug>(coc-definition)'      , 'definition'        ],
        \ 't' : ['<Plug>(coc-type-definition)' , 'type-definition'   ],
        \ 'i' : ['<Plug>(coc-implementation)'  , 'implementation'    ],
        \ 'r' : ['<Plug>(coc-references)'      , 'references'        ],
        \ 'n' : ['<Plug>(coc-diagnostic-next)' , 'next diagnostic'   ],
        \ 'p' : ['<Plug>(coc-diagnostic-prev)' , 'prev diagnostic'   ],
        \ },
      \ }

 let g:which_key_map_leader['g'] = {
      \ 'name' : '+git/version-control',
      \ 't' : [':FloatermNew tig'        , 'tig'                  ],
      \ 'g' : [':FloatermNew lazygit'    , 'lazygit'              ],
      \ 'd' : [':Gdiff'                  , 'fugitive-diff'        ],
      \ 'b' : [':Gblame'                 , 'fugitive-blame'       ],
      \ 'S' : [':Gstatus'                , 'fugitive-status'      ],
      \ 'w' : [':Gwrite'                 , 'fugitive-write'       ],
      \ 's' : {
        \ 'name': '+git/search',
        \ 'c' : [':Commits'              , 'commits log'             ],
        \ 'C' : [':BCommits'             , 'current file commits log'],
        \ },
      \ }

  let g:which_key_map_leader['b'] = {
      \ 'name' : '+buffer' ,
      \ 'd' : ['bd'        , 'delete-buffer'   ],
      \ 'f' : ['bfirst'    , 'first-buffer'    ],
      \ 'h' : ['Startify'  , 'home-buffer'     ],
      \ 'l' : ['blast'     , 'last-buffer'     ],
      \ 'n' : ['bnext'     , 'next-buffer'     ],
      \ 'p' : ['bprevious' , 'previous-buffer' ],
      \ '?' : ['Buffers'   , 'fzf-buffer'      ],
      \ }


  let g:which_key_map_leader['t'] = {
      \ 'name' : '+terminal' ,
      \ 'd' : ['bd'        , 'delete-buffer'   ],
      \ 'f' : ['bfirst'    , 'first-buffer'    ],
      \ 'h' : ['Startify'  , 'home-buffer'     ],
      \ 'l' : ['blast'     , 'last-buffer'     ],
      \ 'n' : ['bnext'     , 'next-buffer'     ],
      \ 'p' : ['bprevious' , 'previous-buffer' ],
      \ '?' : ['Buffers'   , 'fzf-buffer'      ],
      \ }

  call which_key#register(',', "g:which_key_map_localleader")

  let g:which_key_map_localleader =  {}

  nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
  vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  ','<CR>

  let g:which_key_map_localleader['.'] = [ ':lcd %:p:h'          ,  'set working dir'               ]
  let g:which_key_map_localleader['c'] = [ ':let @+= expand("%")',  'copy current dir to clipboard' ]
  let g:which_key_map_localleader['b'] = [ ':<C-u>split'         ,  'horizontal split'              ]
  let g:which_key_map_localleader['v'] = [ ':<C-u>vsplit'        ,  'vertical split'                ]

"}}}

" Vista ---------------------------------------------------------------------{{{

  let g:vista_default_executive = 'coc'

"}}}
