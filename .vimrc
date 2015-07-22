" sourced from
" https://github.com/l3pp4rd/dotfiles/blob/master/vimrc  colorscheme  used plugins(TODO)
" https://github.com/frank604/dotfiles/blob/master/.vimrc  w!!
" TODO merge with  https://github.com/zhuochun/dotfiles/blob/master/vimrc
set runtimepath=~/.vim/,$VIMRUNTIME,~/.vim/bundle/vim-snippets/,~/.vim/after/

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible    " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing

" Now we set some defaults for the editor
" set autoindent    " always set autoindenting on
" set linebreak     " Don't wrap words by default
set textwidth=0     " Don't wrap lines by default
set nobackup
" place for swap files
set dir=~/fshare/.tmp
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than
                        " 50 lines of registers
set viminfo+=n~/fshare/.tmp/.viminfo 
"http://stackoverflow.com/questions/6286866/how-to-tell-vim-to-store-the-viminfo-file-somewhere-else
"http://vim.1045645.n5.nabble.com/search-vimrc-and-viminfo-in-a-different-directory-td4391875.html
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time

" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc


" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd     " Show (partial) command in status line.
set showmatch       " Show matching brackets.
"set ignorecase     " Do case insensitive matching
"set smartcase      " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set wic         " Wildignorecase for cmdline completion especially for filename
"set mouse=a        " Enable mouse usage (all modes) in terminals
set fencs=utf-8,ucs-bom,cp936,gb18310,big5,latin1
set title
"colo molokai
"set autochdir

"https://groups.google.com/forum/#!msg/vim_use/SR12FCxkQYg/aZIGO33waN0J
set diffexpr=MyDiff()
function MyDiff()
   let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-b "
   endif
   silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new .
    \  " > " . v:fname_out
endfunction

runtime! ftplugin/man.vim

if !empty($TMUX)"http://stackoverflow.com/questions/9496769/how-to-correctly-use-undefined-environment-variables-in-vimrc
  if &term =~ "screen"
    set t_ts=k
    set t_fs=\
  endif

endif

if has("autocmd")
 " Uncomment the following to have Vim jump to the last position when
 " reopening a file
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
 " Enable highlight variable under cursor(not smart)
 " http://code.google.com/p/vim-python-ide/source/browse/.vimrc
 " http://stackoverflow.com/questions/1551231/vim-highlight-variable-under-cursor-like-in-netbeans
 " None idea why seperate the "exe" to next with \| make the "l" operator not
 " working
 "au BufRead,BufNewFile *.c,*.cpp,*.js,*.py  autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
 "smth stephenjy 可不可以直接高亮某个词？Tue Nov  6 10:37:12 2012
 "autocmd CursorMoved * silent! exe printf('match Underlined /\<%s\>/', expand('<cword>'))
 "autocmd CursorHold * silent! exe printf('match Underlined /\<%s\>/', expand('<cword>'))

 "http://superuser.com/questions/251019/customizing-tmux-status-to-represent-current-working-directory-and-files
 "http://stackoverflow.com/questions/15123477/tmux-tabs-with-name-of-file-open-in-vim
 "http://vim.wikia.com/wiki/Automatically_set_screen_title
 if !empty($TMUX)
  autocmd BufEnter * let &titlestring = expand('%:.') . ' - VIM'  "TODO man
  auto VimLeave * :set t_ts=k\
  "autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window ". expand("%:t"))
 endif
 "au FILETYPE c set omnifunc=ccomplete#CompleteC
 au FILETYPE c,cpp,javascript,python,rust set nu
 "au BufRead reportbug.*        set ft=mail
 "au BufRead reportbug-*        set ft=mail
endif " has ("autocmd")


noremap <F12> :e ~/.vimrc<CR>
inoremap <F12> <ESC>:e ~/.vimrc<CR>
"nnoremap <C-H> <C-W>h
"nnoremap <C-J> <C-W>j
"nnoremap <C-K> <C-W>k
"nnoremap <C-L> <C-W>l
"imap <C-Tab> <ESC><C-6>i

"*** Command-line-invocation-of-ctags ***
"map  <C-c> :!ctags --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if has("cscope")
    "
    set csprg=/usr/bin/cscope
    set cscopequickfix=s-,c-,d-,t-,e-,f-,i-,g-
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
    " http://cscope.sourceforge.net/cscope_maps.vim
    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following
    " cscope search types:
    "
    " 's'   symbol: find all references to the  token under cursor
    " 'g'   global: find global definition(s) of the token under cursor
    " 'c'   calls:  find all calls to the function name under cursor
    " 't'   text:   find all instances of the text under cursor
    " 'e'   egrep:  egrep search for the word under cursor
    " 'f'   file:   open the filename under cursor
    " 'i'   includes: find files that include the filename under cursor
    " 'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps,
    " as it's unlikely that you need their default mappings (CTRL-\'s default use
    " is as part of CTRL-\ CTRL-N typemap, which basically just does the same thing
    " as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all of these
    " maps to use other keys.  One likely candidate is 'CTRL-_'(which also maps to CTRL-/,
    " which is easier to type).  By default it is used to switch between Hebrew and English
    " keyboard mode. All of the maps involving the <cfile> macro use '^<cfile>$': this is
    " so that searches over '#include <time.h>" return only references to 'time.h', and
    " not 'sys/time.h', etc.  (by default cscope will return all files that contain 'time.h'
    " as part of their name). To do the first type of search, hit 'CTRL-\', followed by one
    " of the  cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope search
    " will be displayed in the current window.  You can use CTRL-T to go back to where you were
    " before the search.
    "nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    "nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    nnoremap <F2> :scs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <F3> :scs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nnoremap <F4> :scs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <F7> :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed
    " in the new window. (Note: earlier versions of vim may not have the :scs
    " command, but it can be simulated roughly via:

    "nmap <C-@>g <C-W><C-S> :cs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-2>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-2>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-2>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-2>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-2>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-2>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-2>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    "Hitting CTRL-space *twice* before the search type does a vertical split
    "instead of a horizontal one (vim 6 and up only) (Note: you may wish to put
    "a 'set splitright' in your .vimrc " if you prefer the new window on the
    "right instead of the left
    "nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
    " key map timeouts
    "
    "By default Vim will only wait 1 second for each keystroke in a mapping.
    "You may find that too short with the above typemaps.  If so, you should
    "either turn off mapping timeouts via 'notimeout'.
"set notimeout
    "Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    "with your own personal favorite value (in milliseconds)
"set timeoutlen=4000
    "Either way, since mapping timeout settings by default also set the timeouts
    "for multicharacter 'keys codes' (like <F1>), you should also set ttimeout
    "and ttimeoutlen: otherwise, you will experience strange delays as vim waits
    "for a keystroke after you hit ESC (it will be waiting to see if the ESC is
    "actually part of a key code like <F1>).
"set ttimeout
    "personally, I find a tenth of a second to work well for key code timeouts.
    "If you experience problems and have a slow terminal or network connection,
    "set it higher.If you don't set ttimeoutlen, the value for timeoutlent
    "(default: 1000 = 1 second,which is sluggish) is used.
 "set ttimeoutlen=100
endif

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set pastetoggle=<F9>

" Allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

"https://github.com/gmarik/Vundle.vim#quick-start
filetype off

"Vim-Plug
"https://github.com/junegunn/vim-plug
let g:plug_timeout=600000 "ycm https://github.com/junegunn/vim-plug/issues/75
call plug#begin('~/.vim/bundle/')

"bundles

"Plug 'tpope/vim-sensible' " sensible defaults for ViM
"Plug 'vim-scripts/gitignore' " use gitignore for wildignore
"Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
"Plug 'tmhedberg/matchit'
"Plug 'mattn/emmet-vim'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-surround'
"Plug 'Raimondi/delimitMate'
"Plug 'groenewege/vim-less', { 'for': 'less' }
"Plug 'tpope/vim-markdown', { 'for': 'markdown' }
"Plug 'evanmiller/nginx-vim-syntax'
"Plug 'mxw/vim-jsx', { 'for': 'jsx' }

Plug 'SirVer/ultisnips' | Plug 'kayw/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'Yggdroot/LeaderF' "http://stackoverflow.com/questions/4108073/is-there-a-vim-plug-in-similar-to-fuzzyfinder-textmate-and-command-t-which-does
Plug 'tpope/vim-fugitive' "http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
Plug 'python_match.vim'
Plug 'gabesoft/vim-ags'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'python', 'javascript', 'markdown'], 'do': './install.sh'} "todo c-family build script
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'wting/rust.vim', {'for': 'rust'}
Plug 'fatih/go.vim', {'for': 'go'}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}

Plug 'dahu/LearnVim'

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'altercation/vim-colors-solarized'

call plug#end()

" Enabled file type detection
" Use the default filetype settings. If you also want to load indent files
" to automatically do language-dependent indenting add 'indent' as well.
filetype plugin on
" Uncomment the following to have Vim load indentation rules according to the
" detected filetype.
filetype indent on

"list search result  use ag.vim todo
map <M-C-F> <ESC>:Ags<Enter>

"UltiSnip
"need improvement https://github.com/Valloric/YouCompleteMe/issues/36
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsListSnippets = "<C-g>"
let g:UltiSnipsJumpForwardTrigger="<C-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-f>"
" this mapping Enter key to <C-y> to chose the current highlight item
" " and close the selection list, same as other IDEs.
" " CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:snips_author="kayw"

"let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]

"airline
set laststatus=2 "http://superuser.com/questions/634570/vim-how-to-install-airline
let g:airline_theme='powerlineish'
let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#bufferline#enabled = 1  "http://stackoverflow.com/questions/4865132/an-alternative-to-minibufexplorer-vim
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#syntastic#enabled = 1

" Nerd tree
nmap <Leader>t :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>

"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/compiler/global.ycm_extra_conf.py'
noremap <Leader>k :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <Leader>k :YcmCompleter GoToDefinitionElseDeclaration<CR>


"Syntastic
"avoid terminal vim flick with ycm
let syntastic_full_redraws = 0 "https://github.com/scrooloose/syntastic/issues/668
let g:syntastic_mode_map = { "mode": "active",
                           \ "active_filetypes": [],
                           \ "passive_filetypes": ["go"] }
let g:syntastic_javascript_checkers = ['jsxhint']  " npm install -g jsxhint

"leadf
let g:Lf_CacheDiretory = '/tmp'

"javascript-vim
let javascript_enable_domhtmlcss=1

"colorscheme
set background=light "dark 
let g:solarized_contrast="low"
let g:solarized_visibility="high"
if $TERM =~ "-256color"
    se t_Co=256
    let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    let g:solarized_termtrans=1
endif
colo solarized
