if exist "c:\Program Files (x86)" goto w64

:w32
xcopy "\\ts17\EQUATION\*.*" "c:\Program Files\Common Files\microsoft shared\EQUATION" /q /Z /Y
regedit /s C:\Program Files\Common Files\microsoft shared\EQUATION\eqnedt_x86.reg
goto end

:w64
xcopy "\\ts17\EQUATION\*.*" "c:\Program Files (x86)\Common Files\microsoft shared\EQUATION" /q /Z /Y
regedit /s C:\Program Files\Program Files (x86)\microsoft shared\EQUATION\eqnedt_x64.reg

:end