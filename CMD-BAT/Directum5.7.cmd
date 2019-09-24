echo off
color 02

set targetWS=SB1723
set nwpatch2=Install\Directum5.7
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
goto end
)
md \\%targetWS%\c$\%nwpatch2%
xcopy "\\10.77.128.206\Obmen\MSI\AutoDel-Inst.cmd" \\%targetWS%\c$\%nwpatch2% /Q /Z
psexec.exe \\%targetWS% "c:\%nwpatch2%\AutoDel-Inst.cmd"
::rmdir /s /q  \\%targetWS%\c$\%nwpatch2%
goto end
:inst
echo INSTALL
:end
pause