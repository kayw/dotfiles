setlocal makeprg=gcc\ -g\ -o\ %
setl et
setl sw=2
setl ts=2
setl sts=2

"setlocal makeprg=cl\ -GX\ \"%:p\"
map <F2> :w<CR>:make<CR>:cwindow<CR><CR>:!%:r.exe<CR> 
"imap <F2> <ESC>:w<CR>:!start vcvars32.bat<CR>:make<CR>:cwindow<CR><CR>:!start %:r.exe<CR> 
imap <F2> <ESC>:w<CR>:make<CR>:cwindow<CR><CR>:!%:r.exe<CR> 

"map <F3> :!start gdb<CR>

map  <F4>  :cope<CR>
imap  <F4>  <ESC>:cope<CR>

imap <F5>  <ESC>:cn<CR>
map  <F5>  :cn<CR>

"map <F11> :tabe $vim/vimfiles/ftplugin/c.vim<CR>
"imap <F11> <ESC>:tabe $vim/vimfiles/ftplugin/c.vim<CR>
map <F11> :tabe $HOME/.vim/ftplugin/c.vim<CR>
imap <F11> <ESC>:tabe $HOME/.vim/ftplugin/c.vim<CR>
