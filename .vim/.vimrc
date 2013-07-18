"Parameter
set mousefocus
set ts=2
set shiftwidth=2
set visualbell
set wildmenu
set expandtab
set colorcolumn=100
set hlsearch

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:jedi#auto_vim_configuration = 1
" Trailing spaces
"autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * call RemoveTrailingWhitespace()

" Project mode
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Nerd Tree
let g:NERDTreeWinPos = "right"

" Tags
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:Tlist_WinWidth = 45

"NerdTree
let g:NERDTreeWinSize = 40

"Omni
filetype on
filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete

"Color
if has("gui_running")
  colorscheme earthburn
else
  colorscheme darkdesert
endif

"MAPPING
map T :TaskList<CR>
map P :TlistToggle<CR>
map <F2> :NERDTreeToggle<CR>
map M :MiniBufExplorer<CR>
nmap <F8> :TagbarToggle<CR>
nmap ; :CtrlPBuffer <CR>

let g:jedi#auto_initialization = 1

function LTUCheck()
  exec "ltu-style-check --no-pylint --help"
endfunction

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"TList First
"Then Buffer

function RemoveTrailingWhitespace()
  if &ft != "diff"
    let b:curcol = col(".")
    let b:curline = line(".")
    silent! %s/\s\+$//
    silent! %s/\(\s*\n\)\+\%$//
    call cursor(b:curline, b:curcol)
  endif
endfunction
