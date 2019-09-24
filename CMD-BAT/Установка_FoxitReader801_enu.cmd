::Install FoxitReader801_enu_Setup.msi
echo off
color 02

set targetWS=sb3848
set nwpatch2=Install\FoxitReader801_enu

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
goto end
)
::if exist "\\%targetWS%\c$\Program Files\Java\jre6" goto inst

md \\%targetWS%\c$\%nwpatch2%
xcopy "\\10.77.128.206\Obmen\MSI\FoxitReader801_enu_Setup.msi" \\%targetWS%\c$\%nwpatch2% /Q /Z
:: ���������
psexec.exe \\%targetWS% msiexec.exe /i c:\%nwpatch2%\FoxitReader801_enu_Setup.msi /qn
:: ��������
:: psexec.exe \\%targetWS% msiexec.exe /x c:\%nwpatch2%\FoxitReader801_enu_Setup.msi /qn
rmdir /s /q  \\%targetWS%\c$\%nwpatch2%
goto end
:inst
echo INSTALL
:end
pause