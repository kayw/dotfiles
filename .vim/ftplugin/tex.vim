setlocal makeprg=latex\ -interaction=nonstopmode\ % 
"setlocal errorformat=%f:\ %l.%c:\ %m
"dvi
map <F2> :w<CR>:make<CR>:copen<CR><CR>

imap <F2> <ESC>:w<CR>:make<CR>:cwindow<CR><CR><CR>

"map <M-2> :w<CR>:!smarttexer -nonstopmode -dvi -quiet %<CR><CR>
"imap <M-2> <ESC>:w<CR>:!smarttexer -nonstopmode -dvi -quiet %<CR><CR>

map <F3> :!start yap  %:p:r.dvi<CR>

imap <F3> <ESC>:!start yap  %:p:r.dvi<CR>

"ps
"map <M-F3> :w<CR>:!smarttexer -once -dvips -quiet %<CR><CR>
"imap <M-F3> <ESC>:w<CR>:!smarttexer -once -dvips -quiet %<CR><CR>

map <C-F4> :w<CR>:!smarttexer  -dvips -view -quiet %<CR><CR>
imap <C-F4> <ESC>:w<CR>:!smarttexer -dvips -view -quiet %<CR><CR>

"map ;sv :!gsview  %:p:r.ps<CR><CR>

"pdf
map <F5> :w<CR>:!smarttexer -once -pdf -quiet %<CR><CR>
imap <F5> <ESC>:w<CR>:!smarttexer -once -pdf -quiet %<CR><CR>

"map <M-6> :w<CR>:!smarttexer -nonstopmode -pdf -view -quiet %<CR><CR>
"imap <M-6> <ESC>:w<CR>:!smarttexer -nonstopmode -pdf -view -quiet %<CR><CR>

"map ;fv :!start "E:\Program Files\Foxit PDF Reader Pro 2.2.2129\Foxit Reader.exe" %:p:r.pdf<CR><CR>
map <F6> :!start "E:\Program Files\Foxit PDF Reader Pro 2.2.2129\Foxit Reader.exe" "%:p:r.pdf"<CR><CR>

imap <F6> <ESC>:!start "E:\Program Files\Foxit PDF Reader Pro 2.2.2129\Foxit Reader.exe" "%:p:r.pdf"<CR><CR>
map <F4> :!dvipdfmx %:r.dvi<CR><CR>
imap <F4> :!dvipdfmx %:r.dvi<CR><CR>

"map <F3> :!dvi2pdf %:p:r.dvi<CR><CR>
"imap <F3> :!dvi2pdf %:p:r.dvi<CR><CR>

"map <tab> <Plug>IMAP_JumpForward
"imap <tab> <Plug>IMAP_JumpForward

map <F11> :tabe $vim/vimfiles/ftplugin/tex.vim<CR>
imap <F11> <ESC>:tabe $vim/vimfiles/ftplugin/tex.vim<CR> 
