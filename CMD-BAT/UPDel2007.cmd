echo off

set targetWS=SB%1

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	color 0C
	echo WARN!!! Host %targetWS% is timed out or unknown.
goto end
)

::delete Patchs Office 2007
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109110000000000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109440091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109510091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109610091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109810091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109910091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109A10091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109B10091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109C20091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109E60091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109F10022400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109F10070400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109F10090400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00002109F10091400000000000F01FEC\Patches" /f
psexec.exe \\%targetWS% reg.exe delete "hkcr\Installer\Products\00004109500200000000000000F01FEC\Patches" /f

:end
pause