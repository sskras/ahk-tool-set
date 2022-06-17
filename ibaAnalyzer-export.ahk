^+r::Reload

^+n::
; saukrs:
;   Via https://www.autohotkey.com/board/topic/120104-get-editbox-text/#entry683452 ;
;   Via https://www.autohotkey.com/docs/commands/ControlGetText.htm#ExBasic ;
ControlGetText, var_new_data_file, Edit1, ahk_exe ibaAnalyzer.exe
MsgBox Read: %var_new_data_file%
Send {Enter}
return
