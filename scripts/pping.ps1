$a=1
while ($a=1) {if (!(Test-Connection -ComputerName $args[0] -buffersize $args[1] )) {write-output ("Host "+$args[0]+" DOWN! ____ "+(get-date -format "HH:mm:ss  MM.dd.yyyy")+" ---by "+ $args[1]+" byte")}}