; 2022-06-17 saukrs: To use with ibaAnalyzer v7.3.6 (somewhat on demand by mikrmd @ Siemens Energy @ Erlangen).

; --------------------------------- Script initialization ---------------------------------
;
var_demo_delay := 400 ;ms                                                       ; Adjust the thing if debug/demo mode is too slow or too fast for you
var_default_delay := 10 ;ms                                                     ; This input delay value seems to be set by AHK by default, will be used when restoring the pace
var_current_delay := var_default_delay                                          ; Set the script input pace to the default value
SetTitleMatchMode, RegEx                                                        ; Matching titles using regular expressions (smart wildcards) as the class of main window get different suffix every run
SetTitleMatchMode, Slow

var_cl := DllCall( "GetCommandLine", "str" )                                    ; Get the whole AHK command line
StringMid, var_path_AHK, var_cl, 2, InStr( var_cl, """", true, 2 )-2            ; Get the executable name from it (we will use it to extract default AHK icon)
Return                                                                          ; Initialization complete (run once per script lifetime)


; -------------------------------- Let's do the main work: --------------------------------
;
#IfWinActive, Open new data file ahk_exe ibaAnalyzer.exe, Show Advanced         ; If "Open new data file" from ibaAnalyzer.exe is not active, skip this block altogther
~RButton up::                                                                   ; Start processing data by clicking the right mouse button on the needed filename
^Enter::                                                                        ; Start processing data using <Ctrl-Enter> too

Menu, Tray, Icon, Shell32.dll, 78                                               ; Set the big exclamation sign in system tray
SetKeyDelay var_current_delay                                                   ; Set the selected delay: either the default (10ms), or the debug-friendly one (eg. 400ms) both configured at the top of script

ControlGetText, var_data_file, Edit1, Open new data file  ahk_exe ibaAnalyzer.exe ; Read name of the file selected in the new data file selection dialog box
StringReplace var_text_file, var_data_file, .dat, .txt                          ; In the just read name replace ".dat" => ".txt" and save into var_text_file

Send {Enter}                                                                    ; Press <Enter>, open the selected data file
WinWaitActive, 220209_EL_Harmonic_Rev_C.pdo - ahk_exe ibaAnalyzer.exe, Main Toolbar ; Return to the main app window
Send {Alt down}f{Alt up}                                                        ; Press <Alt-F>, ie. open the "File" menu
Send {Up 8}{Enter}                                                              ; Go up from the menu bottom to the "Export" item
Send {Tab 6}                                                                    ; In the "Export Selection" window go down to the "Timebase" box (in the "Time selection" panel)
Send +{Left 4}60                                                                ; Change the default value "0.2" to "60" s (for that reduce the selection by 4 characters from right by pressing <Shift-Left> 4x)
Send {Tab 3}                                                                    ; Go to the "Signal selection" panel
Send {Down 2}                                                                   ; Select "Currently visualized signals (expressions)" radio button
Send {Enter}                                                                    ; Press <Enter>, start exporting the data
WinWaitActive, Save text file ahk_exe ibaAnalyzer.exe                           ; Go to the "Save text file" dialog box
ControlSetText, Edit1, %var_text_file%, Save text file ahk_exe ibaAnalyzer.exe  ; Put name of the computed text file into the file saving dialog box
Send {Enter}                                                                    ; Press <Enter> to actually export the text file
WinWaitActive, 220209_EL_Harmonic_Rev_C.pdo - ahk_exe ibaAnalyzer.exe, Main Toolbar ; Return to the main app window
Send {Ctrl down}d{Ctrl up}                                                      ; Press <Ctrl-D>, equivalent of menu > "File" > "Open Data File..."

Menu, Tray, Icon, %var_path_AHK%                                                ; Restore the default AHK icon in system tray
Return                                                                          ; Exit the main handler, done exporting the file
#If


; ---------------------------- Demo mode enabled using delay: -----------------------------
^+d::
if (var_current_delay = var_default_delay)
{
    var_current_delay := var_demo_delay
    MsgBox, Enabling demo mode, setting delay: %var_current_delay% ms
}
else
{
    var_current_delay := var_default_delay
    MsgBox, Disabling demo mode, setting delay: %var_current_delay% ms
}
Return


; ---------- Reload the script (needed after content has changed during the run): ---------
^+r::Reload


; ------------------------ Quit the script (after the job is done): -----------------------
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
