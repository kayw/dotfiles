set runtimepath=~/.vim/,$VIMRUNTIME,~/.vim/bundle/ultisnips/,~/.vim/after/

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

" Now we set some defaults for the editor
" set autoindent	" always set autoindenting on
" set linebreak		" Don't wrap words by default
set textwidth=0		" Don't wrap lines by default
set nobackup
" place for swap files
set dir=/tmp
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
			" 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

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
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set wic			" Wildignorecase for cmdline completion especially for filename
"set mouse=a		" Enable mouse usage (all modes) in terminals
set fencs=utf-8,ucs-bom,cp936,gb18310,big5,latin1
set title
colo molokai
"set autochdir

runtime! ftplugin/man.vim

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

 " Enabled file type detection
 " Use the default filetype settings. If you also want to load indent files
 " to automatically do language-dependent indenting add 'indent' as well.
 filetype plugin on
 " Uncomment the following to have Vim load indentation rules according to the
 " detected filetype.
 filetype indent on
 "au FILETYPE c set omnifunc=ccomplete#CompleteC
 au FILETYPE c,cpp,js,py set nu
 "au BufRead reportbug.*		set ft=mail
 "au BufRead reportbug-*		set ft=mail
endif " has ("autocmd")


noremap <F12> :e ~/.vimrc<CR>
inoremap <F12> <ESC>:e ~/.vimrc<CR>
"nnoremap <C-H> <C-W>h
"nnoremap <C-J> <C-W>j
"nnoremap <C-K> <C-W>k
"nnoremap <C-L> <C-W>l 
" // The switch of the Source Explorer
"nmap <F11> :SrcExplToggle<CR> 
" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8

" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100

" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"

" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" // In order to Avoid conflicts, the Source Explorer should know what plugins
" // are using buffers. And you need add their bufname into the list below
" // according to the command ":buffers!"
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
    \ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" //  create/update a tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

" // Set "<F10>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F10>" 
"imap <C-Tab> <ESC><C-6>i

"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

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

" We know xterm-debian is a color terminal
"if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
"  set t_Co=16
"  set t_Sf=[3%dm
"  set t_Sb=[4%dm
"endif


"if has('gui_running')
"  " Make shift-insert work like in Xterm
"  map <S-Insert> <MiddleMouse>
"  map! <S-Insert> <MiddleMouse>
"endif

set pastetoggle=<F8>

"MRU
let MRU_File = '/home/kayw/.vim/.vim_mru_files'
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
let MRU_Include_Files = '\.c$\|\.h$\|\.cpp$\|\.py$\|\.hpp$\|^[^\.][-[:alnum:]~/_]*[^\.]$'

"MiniBufExplorer
"TODO xterm not regconise c-tab
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplHideWhenDiff = 1

<<<<<<< HEAD
"list result
map <M-F> <ESC>:vimgrep <C-R><C-W> %<Enter>:copen
=======
"list search result
map <M-F> <ESC>:vimgrep <C-R><C-W> %<Enter>:copen

"UltiSnip
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsListSnippets = "<C-g>"
let g:UltiSnipsJumpForwardTrigger="<C-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-f>"
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]


"Vundle
set rtp +=~/.vim/bundle/vundle/
call vundle#rc()

"Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle "SirVer/ultisnips"
Bundle "scrooloose/syntastic"


"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/compiler/global.ycm_extra_conf.py'
noremap <Leader>k :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <Leader>k :YcmCompleter GoToDefinitionElseDeclaration<CR>


"Syntastic
"avoid terminal vim flick with ycm
"https://github.com/scrooloose/syntastic/issues/668
let syntastic_full_redraws = 0
>>>>>>> a5422f2b1315a97cd696b5fe83d5023d73b64181
