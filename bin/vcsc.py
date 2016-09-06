#!/usr/bin/env python
# encoding: utf-8
from __future__ import print_function

import os
import subprocess
import signal
import time
from os.path import join, exists, isdir
from collections import deque  # tutorial/datastructures.html
from multiprocessing import Pool, freeze_support

#test method 1: create directory with directory and .git


class VcsGit:

    @staticmethod
    def name():
        return "Git"

    @staticmethod
    def cmd():
        return "git"

    @staticmethod
    def repo():
        return ".git"

    def pull(self, args):
        return subprocess.check_output([self.cmd(), "pull"] + args,
                                       stderr=subprocess.STDOUT)

    def status(self, args):
        return subprocess.check_output([self.cmd(), "status", "-uno"] + args,
                                       stderr=subprocess.STDOUT)

    def subcommand(self, root):
        sbmfile = join(root, ".gitmodules")
        if exists(sbmfile):
            return GitSubmodule()
        else:
            return None


class GitSubmodule(VcsGit):

    def name(self):
        return "git submodule"

    def pull(self, args):
        return subprocess.check_output(
            [self.cmd(), "submodule", "update", "--recursive"],
            stderr=subprocess.STDOUT)

    def status(self, args):
        return subprocess.check_output(
            [self.cmd(), "submodule", "status", "--recursive"],
            stderr=subprocess.STDOUT)


class VcsMercurial:

    def name(self):
        return "Mercurial"

    def cmd(self):
        return "hg"

    def repo(self):
        return ".hg"

    def pull(self, args):
        return subprocess.check_output([self.cmd(), "pull", "-u"] + args,
                                       stderr=subprocess.STDOUT)

    def status(self, args):
        return subprocess.check_output([self.cmd(), "status", "-u"] + args,
                                       stderr=subprocess.STDOUT)

    def subcommand(self, root):
        return None


available_vcses = [VcsGit(), VcsMercurial()]
vcsc_root = os.getcwd()


def init_worker():
    signal.signal(signal.SIGINT, signal.SIG_IGN)


def vcs_by_repo(root):
    for vcs in available_vcses:
        vcs_dir = join(root, vcs.repo())
        if exists(vcs_dir) and isdir(vcs_dir):
            return vcs
    return None


def RunVcsCmd(args):
    cmd_args_queue = deque()
    root_queue = deque()
    root_queue.append(vcsc_root)

    # CAVEAT: unsupport llvm clang repo structure
    while len(root_queue) > 0:
        root_dir = root_queue.popleft()
        vcs = vcs_by_repo(root_dir)
        if vcs is not None:
            cmd_name = ""
            if args.u:
                cmd_name = "pull"
            elif args.s:
                cmd_name = "status"
            cmd_args_queue.append((root_dir, vcs, cmd_name, args.optargs))
            subvcs = vcs.subcommand(root_dir)
            if subvcs is not None:
                cmd_args_queue.append((root_dir, subvcs, cmd_name))
        else:
            #http://stackoverflow.com/questions/973473/getting-a-list-of-all-subdirectories-in-the-current-directory
            for sub_dir in next(os.walk(root_dir))[1]:
                root_queue.append(join(root_dir, sub_dir))

    mpp = Pool(None, init_worker)

    try:
        for cmd in cmd_args_queue:
            print(cmd)

        #http://stackoverflow.com/questions/5773397/converting-a-deque-object-into-list
        mpp.map_async(run_star, list(cmd_args_queue)).get(9999)

        #http://jtushman.github.io/blog/2014/01/14/python-|-multiprocessing-and-interrupts/
        #http://stackoverflow.com/questions/21104997/keyboard-interrupt-with-pythons-multiprocessing/21106459#21106459
        #http://stackoverflow.com/questions/1408356/keyboard-interrupts-with-pythons-multiprocessing-pool

        #http://stackoverflow.com/questions/11312525/catch-ctrlc-and-exit-multiprocesses-gracefully-in-python
        time.sleep(5)  #todo why must sleep
        mpp.close()
        mpp.join()
    except KeyboardInterrupt:
        print("Caught KeyboardInterrupt, terminating workers")
        mpp.terminate()
        mpp.join()
    except Exception, e:
        print("Caught %s" % e)
        mpp.terminate()
        mpp.join()


#http://stackoverflow.com/questions/5442910/python-multiprocessing-pool-map-for-multiple-arguments
def run_star(cmd):
    # http://stackoverflow.com/questions/15314189/python-multiprocessing-pool-hangs-at-join
    # http://bugs.python.org/issue9400
    try:
        run(*cmd)
    except Exception, e:
        print('caught exception in run_star', e)


def run(root_dir, vcs, cmd_name, args=""):
    os.chdir(vcsc_root)
    with open(str(os.getpid()) + ".log", "a") as logf:
        os.chdir(root_dir)
        logf.write("run command {} in directory {}\n\n".format(vcs.name(
        ) + ' ' + cmd_name + ' ' + args, root_dir))
        #http://stackoverflow.com/questions/3061/calling-a-function-of-a-module-from-a-string-with-the-functions-name-in-python
        stdout = getattr(vcs, cmd_name)(args.split(" "))
        logf.write(stdout + "\n")


def main():
    import argparse
    cmdline = argparse.ArgumentParser(
        description='run vcs command in current directory.')
    #cmdline.add_argument('action', choices=['-u', '-s'], help='current supported vcs command: u for update, s for check status')
    #it seems {-u, -s} need some argument after it, otherwise cause the too few argument error
    #http://stackoverflow.com/questions/16174992/cant-get-argparse-to-read-quoted-string-with-dashes-in-it
    #http://bugs.python.org/issue9334

    group = cmdline.add_mutually_exclusive_group(required=True)
    group.add_argument('-u',
                       action='store_true',
                       help='supported command update')
    group.add_argument('-s',
                       action='store_true',
                       help='supported command status check')

    #cmdline.add_argument('-r', '--recursive', action='store_true', help='whether run command in child directory recursively')
    #http://stackoverflow.com/questions/5262702/argparse-module-how-to-add-option-without-any-argument
    cmdline.add_argument('optargs',
                         nargs='*',
                         default='',
                         help='optional arguments for the vcs command')
    #http://stackoverflow.com/questions/4480075/argparse-optional-positional-arguments
    args = cmdline.parse_args()
    #subprocess.call("work")  # ssh-agent start todo subshell it's now not called
    RunVcsCmd(args)


if __name__ == "__main__":
    main()
