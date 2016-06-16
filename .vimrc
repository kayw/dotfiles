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
" enable by Plug
" syntax on

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
 " No idea why seperate the "exe" to next with \| make the "l" operator not
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
 au FILETYPE c,cpp,javascript,python,rust set nu
endif " has ("autocmd")

" cd to the directory containing the file in the buffer
" https://github.com/olalonde/dotfiles/blob/master/tag-vim/vimrc#L189
nmap <silent> <leader>cd :lcd %:h<CR>
noremap <F12> :e ~/.vimrc<CR>
inoremap <F12> <ESC>:e ~/.vimrc<CR>
"nnoremap <C-H> <C-W>h
"nnoremap <C-J> <C-W>j
"nnoremap <C-K> <C-W>k
"nnoremap <C-L> <C-W>l
"imap <C-Tab> <ESC><C-6>i
" Swap the word the cursor is on with the next word (which can be on a
" newline, and punctuation is "skipped"):
" http://superuser.com/questions/290360/how-to-switch-words-in-an-easy-manner-in-vim
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>:noh<CR>

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set pastetoggle=<F9>  "http://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim

" Allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

" https://www.reddit.com/r/vim/comments/4l00pj/eli5_why_is_nerdtree_discouraged_but_everyone/d3jufab
" I don't use these methods of installing vim plugins.
let g:loaded_getscriptPlugin = 0
let g:loaded_vimballPlugin = 0
let g:loaded_netrwPlugin = 0
" LogiPat seems useful, but I've never touched it.
let g:loaded_logiPat = 0

"Vim-Plug
"https://github.com/junegunn/vim-plug
let g:plug_timeout=600000 "ycm https://github.com/junegunn/vim-plug/issues/75
call plug#begin('~/.vim/bundle/')

"bundles

"Plug 'mattn/emmet-vim', { 'for': ['html', 'css']}
  "let g:user_emmet_install_global = 0
Plug 'Raimondi/delimitMate', { 'for': [ 'cpp', 'javascript', 'go', 'vim' ]}
"Plug 'tpope/vim-markdown', { 'for': 'markdown' }
"Plug 'mxw/vim-jsx', { 'for': 'jsx' }

Plug 'SirVer/ultisnips' | Plug 'kayw/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive' "http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
Plug 'python_match.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'python', 'javascript'], 'do': './install.py --clang-completer --tern-completer'}
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'wting/rust.vim', {'for': 'rust'}
Plug 'fatih/go.vim', {'for': 'go'}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

Plug 'junegunn/fzf', { 'do': './install --all' } "https://www.reddit.com/r/vim/comments/4l00pj/eli5_why_is_nerdtree_discouraged_but_everyone/d3juidx
Plug 'junegunn/fzf.vim' "https://github.com/junegunn/fzf.vim
Plug 'ap/vim-buftabline' "https://www.reddit.com/r/vim/comments/4l00pj/eli5_why_is_nerdtree_discouraged_but_everyone/d3nyg6n

Plug 'scrooloose/nerdcommenter', { 'for': ['python', 'javascript', 'cpp', 'go', 'rust' ] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' } "differ highlight for macro namespace type
Plug 'Chiel92/vim-autoformat', { 'for': [ 'python', 'javascript', 'cpp', 'go', 'rust' ] }

call plug#end()

" Enabled file type detection
" Use the default filetype settings. If you also want to load indent files
" to automatically do language-dependent indenting add 'indent' as well.
filetype plugin on
" Uncomment the following to have Vim load indentation rules according to the
" detected filetype.
filetype indent on

"UltiSnip
"ycm TAB key TODO https://github.com/Valloric/YouCompleteMe/issues/36
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
let g:airline_theme='badwolf'
let g:airline#extensions#disable_rtp_load = 1
"let g:airline#extensions#bufferline#enabled = 1  "http://stackoverflow.com/questions/4865132/an-alternative-to-minibufexplorer-vim
"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#syntastic#enabled = 1
"let g:airline#extensions#ycm#enabled = 1

" Nerd tree
nmap <Leader>t :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>

"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/compiler/global.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
noremap <Leader>k :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <Leader>k :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Syntastic
let syntastic_full_redraws = 0 "https://github.com/scrooloose/syntastic/issues/668 avoid terminal vim flick with ycm
"let g:syntastic_mode_map = { 'mode': 'active',
"                           \ 'active_filetypes': [],
"                           \ 'passive_filetypes': ['go'] }
"https://github.com/fatih/vim-go/issues/144#issuecomment-136145692
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
"https://github.com/scrooloose/syntastic/issues/1736#issuecomment-207448645
let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:syntastic_javascript_eslint_exec = substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
"https://github.com/scrooloose/syntastic/issues/1692 add to package.json { eslint: \"eslint\" }
"let g:syntastic_javascript_eslint_exe = 'npm run eslint --'

"fzf
"copy from leaderf
nnoremap <leader>f :<C-U>Files<CR>
nnoremap <leader>b :<C-U>Buffers<CR>
nnoremap ;s :Ag <C-R><C-W><CR>
vnoremap ;s :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:Ag <C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
"https://www.reddit.com/r/vim/comments/4ffvt1/is_there_a_way_to_switch_between_fzf_commands/

"http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"https://github.com/junegunn/fzf.vim/issues/27
function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
"AgIn dir pattern
command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

"delimitMate
au FileType vim let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
au FileType vim let b:delimitMate_quotes = "' `"

"javascript-vim
let javascript_enable_domhtmlcss=1

"autoformat
"http://stackoverflow.com/a/23496781
"autocmd BufWritePre *.{js,jsx,go,py,go,rs} :Autoformat
"http://stackoverflow.com/a/27334950
au BufWritePre * if &ft =~? 'javascript\|python\|cpp\|go\|rust' | Autoformat | endif

let g:formatdef_eslint_javascript = 'g:eslint_path." --fix"'
let g:formatters_javascript = ['eslint_javascript']
au FileType javascript,python,cpp let g:autoformat_autoindent = 0
let g:formatters_python = [ 'yapf' ]
let g:formatter_yapf_style = 'chromium'

"buftabline
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1

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
