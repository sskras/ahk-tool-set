# 2022-06-19 saukrs: Compile some .ahk scripts into standalone .exe files
#

all:
	echo Hello
	MSYS2_ARG_CONV_EXCL="*" /c/Program\ Files/AutoHotkey/Compiler/Ahk2Exe.exe /in ibaAnalyzer-export.ahk /out ibaAnalyzer-export.exe
