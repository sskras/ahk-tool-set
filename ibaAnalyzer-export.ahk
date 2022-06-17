^+r::Reload

^+n::
ControlGetText, var_new_data_file, Edit1, ahk_exe ibaAnalyzer.exe
MsgBox Read: %var_new_data_file%
return
