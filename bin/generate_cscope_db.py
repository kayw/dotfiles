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
# vim: ts=2:sw=4:tw=80:et:
