ls /usr/lib/|grep -i x11
tracert
pacman -Ss tracert
tracepath btspread.com
vim dwm/config.h 
echo $PWD
python -m pdb hostsutil.py
reset
wget https://huhamhire-hosts.googlecode.com/git-history/gh-pages/update/hostsinfo.json
timedatectl set-timezone
timedatectl status
cd share/codebase/huhamhire-hosts/
vim hostutil_cmd.py 
python -m pdb hostutil_cmd.py 
cd share/codebase/huhamhire-hosts/
nslookup source.android.com 8.8.8.8
repo init -u https://android.googlesource.com/platform/manifest
ping gerrit.googlesource.com
sudo journalctl -b
git remote -v
sudo pacman -Syuu
cd share/codebase/huhamhire-hosts/
rm -rf hostslist.*
git remote set-url fork git@github.com:kayw/huhamhire-hosts.git
git remote add --track master fork git@github.com:kayw/huhamhire-hosts.git
git branch fork
git checkout fork
git add custom.hosts
git add hostutil_cmd.py
git commit -am "own forked cmdline script from tui initial push"
git push fork 
git status
git push fork
git pull fork
git checkout master
git checkout fork
git status
git push fork
git fetch fork
git checkout master 
git checkout fork
git merge fork/master 
git merge fork/master
git merge fork
git merge fork/master
git pull fork --rebase
git rebase fork/master
git merge fork/master
git push fork fork
git push fork fork:master
git push fork:fork
git push fork :fork
cd .vim/bundle/ultisnips/
git fetch fork 
git fetch fork 
git checkout fork/master 
git checkout origin/HEAD 
git merge fork/master 
git checkout fork/master 
git merge origin/master 
git fetch origin 
git checkout origin/HEAD 
git merge origin/master 
git commit -am "previous forked ultisnips"
git merge origin/master 
git checkout fork/master 
rm ctags/UltiSnips.cnf 
git commit -am "previous forked ultisnips"
git merge origin/master 
git checkout master 
git merge fork/master 
git add UltiSnips/
rm -rf ctags/
git pull origin 
git commit -am "add ultisnips in origin/master"
git pull origin 
git diff ftplugin/snippets.vim
git add ctags/UltiSnips.cnf
git commit -am "merge origin/master change?"
git pull origin 
git push fork 
sudo umount mobileShare/
mount -t vboxsf desktopD mobileShare/ 
mount desktopD mobileShare/ 
git clone git@bitbucket.org:kayw/memo.git private-lab
tar -czvf vim.tar bundle/syntastic/
tar --exclude=.git -czvf vim.tar bundle/syntastic/ bundle/LeaderF/ bundle/vim-airline/ bundle/vim-javascript/ bundle/python_match.vim/ bundle/ultisnips/ bundle/vim-bufferline/ colors indent
tar --exclude=.git -czvf vim.tar bundle/vundle/
zip -x '*.git*' -r vim.zip bundle/syntastic/ bundle/LeaderF/ bundle/vim-airline/ bundle/vim-javascript/ bundle/python_match.vim/ bundle/ultisnips/ bundle/vim-bufferline/ colors indent bundle/vundle/
export GTK_IM_MODULE=xim
sudo XMODIFIERS=@im=fcitx GTK_IM_MODULE=xim eclipse 
sudo mount -t vboxsf desktopD mobileShare/ -o defaults,uid=1000,gid=1001,dmode=755,auto
cd mobileShare/codebase/kydroid/
repo sync
git clone https://git.chromium.org/git/chromium.git chromium-git
sudo ./install.sh --uninstall
sudo ./install.sh --libdir=/usr/lib/
nslookup -q=TXT _netblocks.google.com 8.8.8.8
rsync -av --progress .vim/bundle/rust.vim/ share/Program\ Files\ \(x86\)/Vim/vimfiles/bundle/ --exclude .git
sudo pacman -Scc
git status -uno
git clone git@bitbucket.org:kayw/memo.git private-lab
tar -czvf vim.tar bundle/syntastic/
tar --exclude=.git -czvf vim.tar bundle/syntastic/ bundle/LeaderF/ bundle/vim-airline/ bundle/vim-javascript/ bundle/python_match.vim/ bundle/ultisnips/ bundle/vim-bufferline/ colors indent
tar --exclude=.git -czvf vim.tar bundle/vundle/
zip -x '*.git*' -r vim.zip bundle/syntastic/ bundle/LeaderF/ bundle/vim-airline/ bundle/vim-javascript/ bundle/python_match.vim/ bundle/ultisnips/ bundle/vim-bufferline/ colors indent bundle/vundle/
export GTK_IM_MODULE=xim
sudo XMODIFIERS=@im=fcitx GTK_IM_MODULE=xim eclipse 
sudo mount -t vboxsf desktopD mobileShare/ -o defaults,uid=1000,gid=1001,dmode=755,auto
cd mobileShare/codebase/kydroid/
repo sync
git clone https://git.chromium.org/git/chromium.git chromium-git
sudo ./install.sh --uninstall
sudo ./install.sh --libdir=/usr/lib/
nslookup -q=TXT _netblocks.google.com 8.8.8.8
rsync -av --progress .vim/bundle/rust.vim/ share/Program\ Files\ \(x86\)/Vim/vimfiles/bundle/ --exclude .git
./firefox/firefox -P "dev" -private &
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLLVM_CONFIG_EXECUTABLE=/home/kayw/share/codebase/llvm-ecosys/llvm/build/Debug+Asserts/bin/llvm-config
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLLVM_CONFIG_EXECUTABLE=/home/kayw/llvm/build/Debug+Asserts/bin/llvm-config
gdb --args ./generator/codebrowser_generator -b . -p woboq:..:`git describe` -o ~/share/codebase/srcmind/public_html/woboq -a
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLLVM_CONFIG_EXECUTABLE=/home/kayw/share/codebase/srcmind/llvm/build/Debug+Asserts/bin/llvm-config
export CXX=/home/kayw/share/codebase/srcmind/llvm/build/Debug+Asserts/bin/clang++
export CC=/home/kayw/share/codebase/srcmind/llvm/build/Debug+Asserts/bin/clang
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLLVM_CONFIG_EXECUTABLE=/home/kayw/share/codebase/srcmind/llvm/build/Debug+Asserts/bin/llvm-config -DCLANG_INCLUDE_DIR=/home/kayw/share/codebase/srcmind/llvm/build/tools/clang/include/
cmake -DPATH_TO_LLVM_ROOT=/home/kayw/share/codebase/srcmind/llvm/tools/clang/include/ -DEXTERNAL_LIBCLANG_PATH=/home/kayw/share/codebase/srcmind/llvm/build/Debug+Asserts/lib/libclang.so -G "Unix Makefiles" . ../third_party/ycmd/cpp/
gdb --args ./generator/codebrowser_generator -b . -p woboq:..:`git describe` -o ../../../public_html/woboq `git ls-files .. | egrep '*\.cpp$'`
gdb -c core.codebrowser_gen.1000.0a0dc218c933442bae4d0376503b1d1e.10781.1415378018000000 generator/codebrowser_generator
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLLVM_CONFIG_EXECUTABLE=/home/kayw/share/codebase/srcmind/llvm/build/Debug+Asserts/bin/llvm-config -DUSE_CUSTOM_CLANG=true
gdb --args ./generator/codebrowser_generator -b . -p woboq:..:`git describe` -o ../../public_html/woboq `git ls-files .. | egrep '*\.cpp$'`
gdb --args ../../woboq_codebrowser/build3.6/generator/codebrowser_generator -b . -p rtags:.. -o ../../public_html/rtags/ -a
./firefox/firefox -P "dev" &
git ls-files -d
git log --diff-filter=D --summary
sudo mount -t vboxsf desktopD mobileShare/ -o defaults,uid=1000,gid=1001,dmode=755,auto
gdb --args ./build/srcmind -b=examinee/build/ -p=examinee:examinee/ -a
sudo gem install bundler --no-rdoc --no-ri -V
bundle exec jekyll serve -w
time sh -c 'echo "GET /" | nc www.google.com 80 > /dev/null'
sudo locale-gen en_US.UTF-8
urxvt -fn -*-ohsnap.icons-medium-r-*-*-16-*-*-*-*-*-*-*
urxvtc -fn -*-ohsnap.icons-medium-r-*-*-20-*-*-*-*-*-*-*
xfd -fn -*-ohsnap.icons-medium-r-*-*-24-*-*-*-*-*-*-*
printf "\\$(printf '%03o' 0xeb)\n"
sudo mount -t vboxsf H_DRIVE hshare/ -o defaults,uid=1000,gid=1000,dmode=755,auto
