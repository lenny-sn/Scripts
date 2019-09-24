@echo off

if "%1"=="" goto end

set targetWS=%1
set confirm=n
set path1=\\azot\inst\ALL\Office\Grand\UpdateManager\UM
set path2=Install\UM

::check_ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	goto errorping
)

::Kill GrandUM3.exe
pskill.exe \\%targetWS% GrandUM3.exe

::install

md "\\%targetWS%\c$\%path2%"

echo.
echo Copying files.
echo.
xcopy "%path1%\*.*" "\\%targetWS%\c$\%path2%" /H /q /Z /S /Y

psexec.exe \\%targetWS% c:\%path2%\setup.exe /VERYSILENT
if errorlevel 1 (
echo Errors occurred during the installation.
)

rmdir /s /q \\%targetWS%\c$\%path2%

shift

::Kill GrandUM3.exe
pskill.exe \\%targetWS% GrandUM3.exe
echo Install to %targetWS% successfully executed! - %date% - %time% >>\\azot\inst\ALL\Office\Grand\UpdateManager\log.txt
goto end

:errorping
echo ERROR PING %targetWS%. Maybe host down? >>\\azot\inst\ALL\Office\Grand\UpdateManager\log.txt
:end
exit