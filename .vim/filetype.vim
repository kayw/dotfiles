" Vim support file to detect file types
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2012 Aug 02
" Modifier: kayw <kayw@outlook.com>
" Date: 2012 Nov 25 11:39:33 PM

" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

augroup filetypedetect
" Generic configuration file (check this last, it's just guessing!)
au filetypedetect BufNewFile,BufRead,StdinReadPost *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat
	\    && (getline(1) =~ 'C++') |
	\   setf cpp |
	\ endif

au filetypedetect BufNewFile,BufRead,StdinReadPost *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat
	\    && (getline(2) =~ '^========') |
	\   setf markdown |
	\ endif
" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
