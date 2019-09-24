@echo off 
set targetWS=%1
set targetPRF=%2
set source=\\azot\inst\ALL\Office\Grand\Smeta\Indexs_and_prises\7
set folder="\\%targetWS%\C$\Documents and Settings\%targetPRF%\Мои документы\Гранд-Смета\Индексы и текущие цены"
set log=\\azot\inst\ALL\Office\Grand\Smeta\Indexs_and_prises_sync\log.txt

::Ping
ping -n 2 %targetWS% |find "TTL="
if errorlevel 1 (
	goto errorping
)

:start
::xcopy %source% %folder% /d /y /e
echo d|xcopy /y /d /e %source% %folder%
if errorlevel 1 (
	goto errorcopy
)
echo copy to %targetWS% successfully executed! - %date% - %time% >>%log%
goto end

:errorcopy
echo ERROR COPY TO %targetWS%. Maybe access denied >>%log%
goto end

:errorping
echo ERROR PING %targetWS%. Maybe host down? >>%log%
:end
exit








