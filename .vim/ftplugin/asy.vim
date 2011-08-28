setlocal makeprg=asy\ % 
setlocal errorformat=%f:\ %l.%c:\ %m
"imap <F2> <ESC>:w<CR>:silent! asy %<CR>:cwindow<CR>
imap <F2> <ESC>:w<CR>:mak<CR>:cwindow<CR><CR><CR> 

imap <F3> <ESC>:!start "c:\Program Files\MiCTeX\Viewers\gsview" "%<.eps"<CR><CR>
map  <F3> :!start "c:\Program Files\MiCTeX\Viewers\gsview" %<.eps<CR><CR>

imap <F4> <ESC>:w<CR>:!asy % -f pdf<CR><CR>

"imap <F5> <ESC>:!start "E:\Program Files\Foxit PDF Reader Pro 2.2.2129\Foxit Reader.exe" "%:p:r.pdf"<CR><CR>
"map <F5> :!start "E:\Program Files\Foxit PDF Reader Pro 2.2.2129\Foxit Reader.exe" "%:p:r.pdf"<CR><CR>

"map <F2> :w<CR>:silent! exe"!asy %"<CR>:cwindow<CR>
"map <F2> :w<CR>:mak<CR>:cwindow<CR><CR>
"
"map <F4> :w<CR>:!asy % -f pdf<CR><CR>
"
"imap  <F10> <ESC>:tabe $home/.asy/config.asy<CR>
"map  <F10> :tabe $home/.asy/config.asy<CR>
"
"imap <F11> <ESC>:tabe $HOME/.vim/vimfiles/ftplugin/asy.vim<CR>
"map <F11> :tabe $HOME/.vim/vimfiles/ftplugin/asy.vim<CR>
imap <F11> <ESC>:tabe $HOME/.vim/ftplugin/asy.vim<CR>
map <F11> :tabe $HOME/.vim/ftplugin/asy.vim<CR>
