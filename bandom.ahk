; Via: https://www.autohotkey.com/boards/viewtopic.php?t=33478#p155334

#NoEnv
#Persistent

;------------------------------------------------------------------------------
; SET TRAY-MENU
;------------------------------------------------------------------------------
; Menu, Tray, Standard
Menu, Tray, NoStandard ; to remove default menu
;Menu, Tray, Add
Menu, Tray, Add, Run startup, startup
Menu, Tray, Add, Launch Settings Gui, settings 
Menu, Tray, Add
Menu, Tray, Add, Close, CloseGui
Menu, Tray, Click, 1
Menu, Tray, Tip, Your program description

return

startup:
	msgbox, startup
return

settings:
	msgbox, settings
return

CloseGui:
	ExitApp
return


^+r::Reload
^+m::MsgBox Sveiki gyvi iš 2000-ųjų.
^+n::
ControlGetText, OutputVar, Edit1, *Untitled - Notepad
MsgBox Read: %OutputVar%
return


^+c::
; Via: https://www.autohotkey.com/board/topic/6717-how-to-find-autohotkey-directory/#entry40735
cl := DllCall( "GetCommandLine", "str" )
StringMid, path_AHk, cl, 2, InStr( cl, """", true, 2 )-2
MsgBox, %path_AHk%
Return
