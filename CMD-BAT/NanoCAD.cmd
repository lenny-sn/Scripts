::Install nanoCAD
echo off
color 02

set targetWS=SB%1

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
goto end
)
if exist "\\%targetWS%\c$\Program Files\Nanosoft\nanoCAD 2.5\nCad.exe" goto inst
if exist "\\%targetWS%\c$\Program Files\Nanosoft\nanoCAD 3.0\nCad.exe" goto inst
if exist "\\%targetWS%\c$\Program Files\Nanosoft\nanoCAD 5.1\nCad.exe" goto inst

::Проверка OS
if exist \\%targetWS%\c$\WINDOWS goto start
if exist \\%targetWS%\c$\WINNT goto end

:start
md \\%targetWS%\c$\install\nanocad
echo Copy Files
xcopy "\\Azot\inst\ALL\Drawing\nanoCAD\NC51B(2039)\*.*" \\%targetWS%\c$\install\nanocad /H /q /Z /S

psexec.exe \\%targetWS% "C:\Install\nanoCAD\PreReq\vcredist_x86.exe" /q
psexec.exe \\%targetWS% MsiExec.Exe /i C:\Install\nanoCAD\nanoCAD.msi /qn
psexec.exe \\%targetWS% C:\Install\nanoCAD\reg.cmd

rmdir /s /q  \\%targetWS%\c$\install\nanocad
goto end
:inst
echo INSTALL
:end
pause