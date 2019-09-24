param (
[Parameter (Mandatory=$true, Position=1)]
[string]$cname,

[Parameter (Mandatory=$false, Position=2)]
[int]$bsize=32
)
$a=1
while ($a=1) {if (!(Test-Connection -ComputerName $cname -buffersize $bsize -Quiet)) {write-output ("Host "+$cname+" DOWN! ____ "+(get-date -format "HH:mm:ss  MM.dd.yyyy")+" ---by "+ $bsize+" byte")}}