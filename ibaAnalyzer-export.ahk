^+r::Reload

^+n::
; saukrs:
;   Via https://www.autohotkey.com/board/topic/120104-get-editbox-text/#entry683452 ;
;   Via https://www.autohotkey.com/docs/commands/ControlGetText.htm#ExBasic ;
ControlGetText, var_new_data_file, Edit1, Open new data file  ahk_exe ibaAnalyzer.exe
; MsgBox Read: %var_new_data_file%
StringReplace var_save_text_file, var_new_data_file, .dat, .txt
; MsgBox Read: %var_save_text_file%

Send {Enter}
Sleep 600
Send {Alt down}f{Alt up}
Send {Up 8}{Enter}
Send {Tab 6}
Send +{Left 4}60
Send {Tab 3}
Send {Down}
Send {Enter}
Sleep 1000
; Send %var_new_data_file%
; SendInput %var_new_data_file%
ControlSetText, Edit1, %var_save_text_file%, Save text file ahk_exe ibaAnalyzer.exe
return


; The `Open new data file` dialog box:
;
; Open new data file 
; ahk_class #32770
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	Edit1


; The main app window:
;
; 220209_EL_Harmonic_Rev_C.pdo - C:\Users\saukrs\Downloads\REC3_EL12_2022-06-07_00.13.56.dat - ibaAnalyzer v7.3.6 (x64)
; ahk_class Afx:0000000140000000:b:0000000000010003:0000000000000006:0000000000AD044B
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	IBA_PDOView1


; The `Save text file` dialog box:
;
; Save text file
; ahk_class #32770
; ahk_exe ibaAnalyzer.exe
; ahk_pid 6228
; 
; ClassNN:	Edit1
