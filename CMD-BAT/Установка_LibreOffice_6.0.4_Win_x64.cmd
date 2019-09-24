::Install LibreOffice_6.0.4_Win_x64.msi
echo off
color 02

set targetWS=10.77.128.140
set nwpatch2=Install\LibreOffice_6.0.4

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
goto end
)
::if exist "\\%targetWS%\c$\Program Files\Java\jre6" goto inst

md \\%targetWS%\c$\%nwpatch2%
xcopy "\\10.77.128.206\Obmen\MSI\LibreOffice_6.0.4_Win_x64.msi" \\%targetWS%\c$\%nwpatch2% /Q /Z
:: Установка
psexec.exe \\%targetWS% msiexec.exe /i c:\%nwpatch2%\LibreOffice_6.0.4_Win_x64.msi /qn
:: Удаление
::psexec.exe \\%targetWS% msiexec.exe /x c:\%nwpatch2%\LibreOffice_6.0.4_Win_x64.msi /qn
rmdir /s /q  \\%targetWS%\c$\%nwpatch2%
goto end
:inst
echo INSTALL
:end
pause