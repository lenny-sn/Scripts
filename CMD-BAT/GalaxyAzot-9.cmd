::reg Galaxy Azot dll
echo off
:reconfig
color 07

if "%1"=="" goto end

set log=c:\inst\Galaxy\azotdll.log
set targetWS=%1
set inoDEL=_
set SoftDEL=_

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
set ping=ERROR_PING	
goto log
)
set ping=OK

if exist "\\%targetWS%\c$\CommDocs\Gal9_atl53" goto inst
set SoftDEL=NOT
goto log


:inst
echo copy files
xcopy c:\inst\Galaxy\!\azotreg_9.bat "\\%targetWS%\c$\CommDocs\Gal9_atl53\exe\ocx" /H /q /Z /S

psexec.exe \\%targetWS% "c:\CommDocs\Gal9_atl53\exe\ocx\azotreg_9.bat" 
if errorlevel 1 (
set NWDEL=EROR        
goto log
)
set NWDEL=OK


:log
date /t>>%log%
time /t>>%log%
echo %targetWS%>>%log%
echo Ping: %ping%>>%log% %targetWS%>>%log%
echo Galaxy DLL: %NWDEL%>>%log% %SoftDEL%>>%log%
echo ------------------------>>%log%

shift
goto reconfig

:end
pause

