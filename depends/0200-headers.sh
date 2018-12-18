#!/bin/sh
# I've replaced old, file-based header check by new hybrid check.

. ../depends.sh

check_headers	libELF			elf.h libelf.h gelf.h
check_headers	'libUSB (legacy)'	usb.h
check_headers	NCurses			ncurses.h
check_headers	ZLib			zlib.h
check_headers	'GNU Readline'		readline/readline.h
