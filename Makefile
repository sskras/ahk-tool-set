# 2022-06-19 saukrs: Compile some .ahk scripts into standalone .exe files
#

all:
	echo Hello
	/c/Program\ Files/AutoHotkey/Compiler/Ahk2Exe.exe /in ibaAnalyzer-export.ahk /out ibaAnalyzer-export.exe
