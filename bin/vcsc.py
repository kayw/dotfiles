#!/usr/bin/env python
# encoding: utf-8
from __future__ import print_function

import os
import subprocess
from os.path import join, exists, isdir
from collections import deque #tutorial/datastructures
from multiprocessing import Pool,freeze_support
class VcsCmd(dict):

    """vcs cmd to describe how to use version control system like mercurial, git
	name
	cmd  // name of binary to invoke command

	createCmd   // command to download a fresh copy of a repository
	downloadCmd // command to download updates into an existing repository

	tagCmd         []tagCmd // commands to list tags
	tagLookupCmd   []tagCmd // commands to lookup tags before running tagSyncCmd
	tagSyncCmd     string   // command to sync to specific tag
	tagSyncDefault string   // command to sync to default tag
    """

    #http://stackoverflow.com/questions/2466191/set-attributes-from-dictionary-in-python
    def __getattr__(self, name):
        try:
            return self[name]
        except KeyError as e:
            raise AttributeError(e)

    def __setattr__(self, name, value):
        self[name] = value

vcs_git = VcsCmd(name="Git", cmd="git", downloadCmd="pull", statusCmd='status -uno', submoduleCmd={"downloadCmd": "submodule update --recursive",
                                                                                                   "statusCmd": "submodule status --recursive"})
vcs_hg = VcsCmd(name="Mecurial", cmd="hg", downloadCmd="pull -u", statusCmd="status -u", submoduleCmd=None)

available_vcses = [vcs_hg, vcs_git]

def init_worker():
    signal.signal(signal.SIGINT, signal.SIG_IGN)

def RunVcsCmd(vcs_root, child_dir_level, cmd_str, args):
    cmd_args_queue = deque()
    root_queue = deque()
    root_queue.append(vcs_root)
    ignore_subchild_dir = False
    if child_dir_level == -1:
        ignore_subchild_dir = True
        for root, dirs, _ in os.walk(root_dir):
            for child_dir in dirs:
                root_queue.append(join(root, child_dir))

    while len(root_queue) > 0:
        root_dir = root_queue.popleft()
        for vcs in available_vcses:
            cmd_dir = join(root_dir, "." + vcs.cmd)
            if exists(cmd_dir) and isdir(cmd_dir):
                cmd_args_queue.append((root_dir, vcs.cmd, vcs[cmd_str], args))
                if vcs.submoduleCmd is not None:
                    cmd_args_queue.append((root_dir, vcs.cmd, vcs.submoduleCmd[cmd_str], ''))
                break
            #todo we may use another staticmethod class to process vcs cmd_str and check submodule more carefully
        if not ignore_subchild_dir and child_dir_level is not 0:
            child_dir_level = child_dir_level - 1
            for sub_dir in next(os.walk(root_dir))[1]:#os.listdir(root_dir) this'll also have file names
                #http://stackoverflow.com/questions/973473/getting-a-list-of-all-subdirectories-in-the-current-directory
                root_queue.append(join(root_dir, sub_dir))


    mpp = Pool()

    try:
        #print(list(cmd_args_queue))
        #http://stackoverflow.com/questions/5773397/converting-a-deque-object-into-list
        mpp.map(run_star, list(cmd_args_queue))
        #http://stackoverflow.com/questions/3822512/chunksize-parameter-in-pythons-multiprocessing-pool-map
        #http://stackoverflow.com/questions/9874042/using-pythons-multiprocessing-module-to-execute-simultaneous-and-separate-seawa

        #http://jtushman.github.io/blog/2014/01/14/python-|-multiprocessing-and-interrupts/
        #http://stackoverflow.com/questions/21104997/keyboard-interrupt-with-pythons-multiprocessing/21106459#21106459
        #http://stackoverflow.com/questions/11312525/catch-ctrlc-and-exit-multiprocesses-gracefully-in-python
        mpp.close()
        mpp.join()
    except KeyboardInterrupt:
        print("Caught KeyboardInterrupt, terminating workers")
        mpp.terminate()
        mpp.join()

#http://stackoverflow.com/questions/5442910/python-multiprocessing-pool-map-for-multiple-arguments
def run_star(cmd):
    run(*cmd)

def run(root_dir, cmd, subcmd, args):
    #http://stackoverflow.com/questions/7714868/python-multiprocessing-how-can-i-reliably-redirect-stdout-from-a-child-process
    #http://stackoverflow.com/questions/2331339/piping-output-of-subprocess-popen-to-files
    with open(str(os.getpid()) + ".log", "w") as logf:
        cur_dir = os.getcwd()
        os.chdir(root_dir)
        #http://stackoverflow.com/questions/18344932/python-subprocess-call-stdout-to-file-stderr-to-file-display-stderr-on-scree
        #see also http://codereview.stackexchange.com/questions/6567/how-to-redirect-a-subprocesses-output-stdout-and-stderr-to-logging-module
        logf.write("run command %s in directory %s" % (cmd + ' ' + subcmd + ' ' + args, root_dir))
        cmd_args = [cmd]
        cmd_args.extend(subcmd.split())
        cmd_args.extend(args.split())
        subprocess.check_call(cmd_args, stdout=logf, stderr=logf)
        os.chdir(cur_dir)
        #another way use bash redirection http://stackoverflow.com/questions/26855464/bash-fetch-stdout-stderr-of-python-multiprocessing-process

def main():
    import argparse
    cmdline = argparse.ArgumentParser(description='run vcs command in current directory.')
    #cmdline.add_argument('action', choices=['-u', '-s'], help='current supported vcs command: u for update, s for check status')
    #it seems {-u, -s} need some argument after it, otherwise cause the too few argument error
    #http://stackoverflow.com/questions/16174992/cant-get-argparse-to-read-quoted-string-with-dashes-in-it
    #http://bugs.python.org/issue9334

    group = cmdline.add_mutually_exclusive_group(required=True)
    group.add_argument('-u', action='store_true', help='vcs supported command for update')
    group.add_argument('-s', action='store_true', help='vcs supported command for status check')

    #cmdline.add_argument('-r', '--recursive', action='store_true', help='whether run command in child directory recursively')
    #http://stackoverflow.com/questions/5262702/argparse-module-how-to-add-option-without-any-argument
    cmdline.add_argument('-l', '--level', type=int, help='command run in child directory level, default search every directory')
    cmdline.add_argument('optargs', nargs='*', default='', help='optional arguments for the vcs command') 
    #http://stackoverflow.com/questions/4480075/argparse-optional-positional-arguments
    cur_dir = os.getcwd() #http://stackoverflow.com/questions/3430372/how-to-get-full-path-of-current-files-directory-in-python
    args = cmdline.parse_args()
    cmd_str = ""
    if args.u: 
        cmd_str = 'downloadCmd'
    elif args.s:
        cmd_str = 'statusCmd'
    level = -1 if args.level is None else args.level
    RunVcsCmd(cur_dir, level, cmd_str, args.optargs)

if __name__ == "__main__":
    main()

"""
http://stackoverflow.com/questions/35988/c-like-structures-in-python
from collections import namedtuple
MyStruct = namedtuple("MyStruct", "field1 field2 field3")

m = MyStruct("foo", "bar", "baz")

#use named arguments:

m = MyStruct(field1 = "foo", field2 = "bar", field3 = "baz")

http://programmers.stackexchange.com/questions/160689/is-it-a-better-practice-pre-initialize-attributes-in-a-class-or-to-add-them-alo
class DataObj: #Bunch class
    "Catch-all data object"
    def __init__(self, **kwds):
        self.__dict__.update(kwds)

    def processData(inputs):
        data = DataObj(a=1, b="sym", c=[2,5,2,1])
"""

