#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import argparse
from os import popen

parser = argparse.ArgumentParser(description='Generate Cscope databse')
parser.add_argument('folder', nargs=1)
parser.add_argument('-exclude', nargs='+', dest='exclude_folders')
# TODO: include folders in exclude folders
arg = parser.parse_args()
cmd = "find " + arg.folder[0] + " "
if arg.exclude_folders:
	for excludefolder in arg.exclude_folders:
		cmd = cmd + "-path \"" + arg.folder[0] + "/" + excludefolder + "/*\"" +" -prune -o "
cmd = cmd + "-name \"*.[chp]*\" -print > cscope.files" 
popen(cmd)

#http://blog.csdn.net/freelyc/archive/2009/03/03/3953240.aspx
#!/bin/sh
find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files
cscope -bkq -i cscope.files
# vim: ts=2:sw=4:tw=80:et:
