; 2022-06-17 saukrs: To use with ibaAnalyzer v7.3.6 (somewhat on demand by mikrmd.

; Via https://www.autohotkey.com/docs/commands/SetKeyDelay.htm#Parameters ;
var_default_delay := 10 ;ms
var_demo_delay := 400 ;ms
var_current_delay := var_default_delay

; Demo mode enabled using delay:
^+d::
; SetKeyDelay 300 ;ms
if (var_current_delay = var_default_delay)
{
    var_current_delay := var_demo_delay ;ms
    MsgBox Enabling demo mode, setting delay: %var_current_delay% ms
}
else
{
    var_current_delay := 10 ;ms
    MsgBox Disabling demo mode, setting delay: %var_current_delay% ms
}
Return

; Reload the script (needed after content has changed during the run):
^+r::Reload

; Quit the script (after the job is done):
;   Via https://stackoverflow.com/questions/45700383/how-do-i-stop-an-active-autohotkey-script/45700384#45700384
^+q::ExitApp

; Let's do the main work:
;
#IfWinActive, ahk_class #32770 ahk_exe ibaAnalyzer.exe
;   Via https://www.autohotkey.com/docs/Hotkeys.htm#Remarks ;
~RButton::
; ^Enter::
;   Via https://www.autohotkey.com/board/topic/120104-get-editbox-text/#entry683452 ;
;   Via https://www.autohotkey.com/docs/commands/ControlGetText.htm#ExBasic ;
ControlGetText, var_new_data_file, Edit1, Open new data file  ahk_exe ibaAnalyzer.exe
; MsgBox Read: %var_new_data_file%
;   Via https://www.autohotkey.com/docs/commands/StringReplace.htm#ExVar ;
StringReplace var_save_text_file, var_new_data_file, .dat, .txt
; MsgBox Read: %var_save_text_file%

;   Via https://www.autohotkey.com/board/topic/94685-slowing-down-the-rate-in-which-the-script-enters-the-text/#entry596708 ;
SetKeyDelay var_current_delay

Sleep 200 ;ms
Send {Enter}
Sleep 600 ;ms
Send {Alt down}f{Alt up}
Send {Up 8}{Enter}
Send {Tab 6}
Send +{Left 4}60 ; changing "0.2" s defaults to "60" s
Send {Tab 3}
Sleep 200 ;ms
Send {Down}
Sleep 200 ;ms
Send {Down}
Send {Enter}
Sleep 1000 ;ms
; Send %var_new_data_file%
; SendInput %var_new_data_file%
;   Via https://www.autohotkey.com/boards/viewtopic.php?t=103095#p458907 ;
;   Via https://www.autohotkey.com/docs/commands/ControlSetText.htm#ExBasic ;
ControlSetText, Edit1, %var_save_text_file%, Save text file ahk_exe ibaAnalyzer.exe
Send {Enter}
Sleep 400 ;ms
;   Via https://www.autohotkey.com/boards/viewtopic.php?t=62395#p265596 ;
;   Via https://www.autohotkey.com/docs/commands/WinActivate.htm ;
WinActivate, ahk_class Afx:0000000140000000:b:0000000000010003:0000000000000006:0000000000AD044B ahk_exe ibaAnalyzer.exe
;   Via https://www.autohotkey.com/docs/commands/ControlFocus.htm#ExBasic ;
ControlFocus, IBA_PDOView1, ahk_exe ibaAnalyzer.exe
Send {Ctrl down}d{Ctrl up}
return

; End-of-Code


; The `Open new data file` dialog box:
;
; ------------------------------------
; Open new data file 
; ahk_class #32770
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	Edit1
; ------------------------------------


; The main app window:
;
; ------------------------------------
; 220209_EL_Harmonic_Rev_C.pdo - C:\Users\saukrs\Downloads\REC3_EL12_2022-06-07_00.13.56.dat - ibaAnalyzer v7.3.6 (x64)
; ahk_class Afx:0000000140000000:b:0000000000010003:0000000000000006:0000000000AD044B
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	IBA_PDOView1
; ------------------------------------


; The `Save text file` dialog box:
;
; ------------------------------------
; Save text file
; ahk_class #32770
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	Edit1
; ------------------------------------
