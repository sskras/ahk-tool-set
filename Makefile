# 2022-06-19 saukrs: Compile some .ahk scripts into standalone .exe files
#

# Use the installed AHK compiler version:
PATH := $(PATH):/c/Program\ Files/AutoHotkey/Compiler
SHELL := env PATH=$(PATH) /bin/bash

all:
	echo Hello
	# Don't convert forward slashes into WinAPI file names;
	# Via: https://stackoverflow.com/questions/7250130/how-to-stop-mingw-and-msys-from-mangling-path-names-given-at-the-command-line/65570275#65570275
	MSYS2_ARG_CONV_EXCL="*" Ahk2Exe.exe /in ibaAnalyzer-export.ahk /out ibaAnalyzer-export.exe
