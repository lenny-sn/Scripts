::Install adobe_flash_player.msi
echo off
color 02

set targetWS=sb3598
set nwpatch2=Install\adobe_flash_player

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
goto end
)
::if exist "\\%targetWS%\c$\Program Files\Java\jre6" goto inst

md \\%targetWS%\c$\%nwpatch2%
xcopy "\\10.77.128.206\all\adobe_flash_player\ALL_Flash Player\fp_32.0.0.223_archive\32_0_r0_223\flashplayer32_0r0_223_win.msi" \\%targetWS%\c$\%nwpatch2% /Q /Z
:: Установка
psexec.exe \\%targetWS% msiexec.exe /i c:\%nwpatch2%\flashplayer32_0r0_223_win.msi /quiet
:: Удаление
::psexec.exe \\%targetWS% msiexec.exe /x c:\%nwpatch2%\flashplayer32_0r0_101_win.msi /qn
rmdir /s /q  \\%targetWS%\c$\%nwpatch2%
goto end
:inst
echo INSTALL
:end
pause