; 2022-06-17 saukrs: To use with ibaAnalyzer v7.3.6 (somewhat on demand by mikrmd @ Siemens Energy @ Erlangen).

; --------------------------------- Script initialization ---------------------------------
;
var_demo_delay := 400 ;ms                                                       ; Adjust the thing if debug/demo mode is too slow or too fast for you
; Via: https://www.autohotkey.com/docs/commands/SetKeyDelay.htm#Parameters
var_default_delay := 10 ;ms                                                     ; This input delay value seems to be set by AHK by default, will be used when restoring the pace
var_current_delay := var_default_delay                                          ; Set the script input pace to the default value
SetTitleMatchMode, RegEx                                                        ; Matching titles using regular expressions (smart wildcards) as the class of main window get different suffix every run
SetTitleMatchMode, Slow

; Via: https://www.autohotkey.com/board/topic/6717-how-to-find-autohotkey-directory/#entry40735
var_cl := DllCall( "GetCommandLine", "str" )                                    ; Get the whole AHK command line
StringMid, var_path_AHK, var_cl, 2, InStr( var_cl, """", true, 2 )-2            ; Get the executable name from it (we will use it to extract default AHK icon)
Return                                                                          ; Initialization complete (run once per script lifetime)


; -------------------------------- Let's do the main work: --------------------------------
;
#IfWinActive, Open new data file ahk_class #32770 ahk_exe ibaAnalyzer.exe, Show Advanced
; Via: https://www.autohotkey.com/docs/Hotkeys.htm#Remarks
~RButton up::                                                                   ; Start processing data by clicking the right mouse button on the needed filename
^Enter::                                                                        ; Start processing data using <Ctrl-Enter> too

; Via: https://www.autohotkey.com/docs/commands/Menu.htm#Icon
Menu, Tray, Icon, Shell32.dll, 78                                               ; Set the big exclamation sign in system tray
; Via: https://www.autohotkey.com/board/topic/94685-slowing-down-the-rate-in-which-the-script-enters-the-text/#entry596708
SetKeyDelay var_current_delay                                                   ; Set the computed delay: either the default (10ms), or the debug-friendly one (eg. 400ms), configured at the top of script

; Via: https://www.autohotkey.com/board/topic/120104-get-editbox-text/#entry683452
; Via: https://www.autohotkey.com/docs/commands/ControlGetText.htm#ExBasic
ControlGetText, var_new_data_file, Edit1, Open new data file  ahk_exe ibaAnalyzer.exe
;MsgBox, Read: %var_new_data_file%
; Via: https://www.autohotkey.com/docs/commands/StringReplace.htm#ExVar
StringReplace var_save_text_file, var_new_data_file, .dat, .txt
;MsgBox, Read: %var_save_text_file%

; ControlFocus, Edit1, Open new data file  ahk_exe ibaAnalyzer.exe
Send {Enter}
WinWaitActive, 220209_EL_Harmonic_Rev_C.pdo - ahk_class Afx:0000000140000000:b:0000000000010003:0000000000000006:00000000.+ ahk_exe ibaAnalyzer.exe, Main Toolbar
Send {Alt down}f{Alt up}
Send {Up 8}{Enter}
Send {Tab 6}
Send +{Left 4}60 ; changing "0.2" s defaults to "60" s
Send {Tab 3}
Send {Down 2}
Send {Enter}
WinWaitActive, Save text file ahk_exe ibaAnalyzer.exe
;Send %var_new_data_file%
;SendInput %var_new_data_file%
; Via: https://www.autohotkey.com/boards/viewtopic.php?t=103095#p458907
; Via: https://www.autohotkey.com/docs/commands/ControlSetText.htm#ExBasic
ControlSetText, Edit1, %var_save_text_file%, Save text file ahk_exe ibaAnalyzer.exe
Send {Enter}
WinWaitActive, 220209_EL_Harmonic_Rev_C.pdo - ahk_class Afx:0000000140000000:b:0000000000010003:0000000000000006:00000000.+ ahk_exe ibaAnalyzer.exe, Main Toolbar
; Via: https://www.autohotkey.com/boards/viewtopic.php?t=62395#p265596
; Via: https://www.autohotkey.com/docs/commands/WinActivate.htm
;WinActivate, 220209_EL_Harmonic_Rev_C.pdo - ahk_class Afx:0000000140000000:b:0000000000010003:0000000000000006:0000000000AD044B ahk_exe ibaAnalyzer.exe
; Via: https://www.autohotkey.com/docs/commands/ControlFocus.htm#ExBasic
ControlFocus, IBA_PDOView1, ahk_exe ibaAnalyzer.exe
Send {Ctrl down}d{Ctrl up}

; Via: https://www.autohotkey.com/boards/viewtopic.php?t=33478#p155229
Menu, Tray, Icon, %var_path_AHK%
Return
#If


; ---------------------------- Demo mode enabled using delay: -----------------------------
^+d::
if (var_current_delay = var_default_delay)
{
    var_current_delay := var_demo_delay ;ms
    MsgBox, Enabling demo mode, setting delay: %var_current_delay% ms
}
else
{
    var_current_delay := 10 ;ms
    MsgBox, Disabling demo mode, setting delay: %var_current_delay% ms
}
Return


; ---------- Reload the script (needed after content has changed during the run): ---------
^+r::Reload


; ------------------------ Quit the script (after the job is done): -----------------------
; Via: https://stackoverflow.com/questions/45700383/how-do-i-stop-an-active-autohotkey-script/45700384#45700384
^+q::ExitApp

; -------------------------------------- End-of-Code --------------------------------------


; The `Open new data file` dialog box:
;
; ------------------------------------
; Open new data file 
; ahk_class #32770
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	Edit1
; Visible Text:
;   OK
;   Close
;   Tree1
;   Preferred folders:
;   List
;   Report
;   Up
;   New
;   +
;   -
;   List1
;   Path:
;   File:
;   C:\Users\saukrs\Downloads
;   Append files on multiselect
;   Search
;   Show Advanced
;   Info
;   Tree
;   Preview
;   List
;   Report
;   Add
;   Del
;   Clear
;   Load
;   Save
;   Open from File Group
;   File type:
;   Start Time:
;   File time:
;   Sampling time:
;   File:
;   [0:0]
;   Preview signal:
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
; Visible Text:
;   Signals
;   Signals
;   Signal definitions
;   Signal definitions
;   E
;   Reload
;   File Group
;   Main Toolbar
;   Menu Bar
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
; Visible Text:
;   OK
;   Close
;   Tree1
;   Preferred folders:
;   List
;   Report
;   Up
;   New
;   +
;   -
;   List1
;   Path:
;   File:
;   C:\Users\saukrs\Downloads
;   Info
;   Tree
;   Preview
;   List
;   Report
;   Add
;   Del
;   Clear
;   Load
;   Save
;   Open from File Group
; ------------------------------------
