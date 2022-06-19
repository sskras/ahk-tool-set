# 2022-06-19 saukrs: Compile some .ahk scripts into standalone .exe files
#

# Use the installed AHK compiler version:
PATH := $(PATH):/c/Program\ Files/AutoHotkey/Compiler
SHELL := env PATH=$(PATH) /bin/bash

all:
	echo Hello
	MSYS2_ARG_CONV_EXCL="*" Ahk2Exe.exe /in ibaAnalyzer-export.ahk /out ibaAnalyzer-export.exe
