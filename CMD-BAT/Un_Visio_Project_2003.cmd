::Uninstall Project 2003
start /wait reg.exe delete "hkcr\Installer\Products\9140B30900063D11C8EF10054038389C\Patches" /f
start /wait MsiExec.Exe /x {903B0419-6000-11D3-8CFE-0150048383C9} /qn

::Uninstall Visio 2003
start /wait reg.exe delete "hkcr\Installer\Products\9040150900063D11C8EF10054038389C\Patches" /f
start /wait MsiExec.Exe /x {90510409-6000-11D3-8CFE-0150048383C9} /qn
