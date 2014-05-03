" Vim plugin -- yet another template script tool
" Maintainer:  kayw <kayw@outlook.com>
" Last Change: 2014 April 16

let s:ignoreFileList = ["makefile"]
let s:VIMHOME = expand("<sfile>:p:h:h")
" usage call LoadTemplate("interview-cc", "file1")
func! LoadTemplate(templateName, dirName)
  let curDir = escape(expand("%:p:h"), '\')
  let newDirPath = curDir .'/'. a:dirName
  "exec '!mkdir'.' '.newDirPath
  call system("mkdir ".newDirPath)
  let templateDir = s:VIMHOME.'/templates/'.a:templateName.'/'
  for templatefilepath in split(globpath(templateDir, '**'), '\n')
    let fileLen = strlen(templatefilepath)
    let lastSlashPos = strridx(templatefilepath, '/')
    let templatefile = templatefilepath[lastSlashPos+1:fileLen]
    for ignoreFileName in s:ignoreFileList
      if templatefile != ignoreFileName
      	let lastDotPos = strridx(templatefile, ".")
      	let strLen = strlen(templatefile)
      	let suffix = templatefile[lastDotPos+1:strLen]
      	let newFilePath = newDirPath.'/'.a:dirName.'.'.suffix
      else
	let newFilePath = newDirPath.'/'.templatefile
      endif
      "exec '!cp'.' '.templatefilepath.' '.newFilePath 
      call system("cp ".templatefilepath." ".newFilePath)
    endfor
  endfor
endfunc

"tw=:ts=2:ft=viml:
"http://learnvimscriptthehardway.stevelosh.com/chapters/40.html
"http://stackoverflow.com/questions/16485748/vimscript-how-to-get-the-parent-directory-of-a-path-string
"http://stackoverflow.com/questions/18693842/vim-scripting-how-to-make-a-variable-to-host-command
"http://superuser.com/questions/119991/how-do-i-get-vim-home-directory
"http://vim.1045645.n5.nabble.com/OS-agnostic-path-separator-td1187176.html
