$Username = ‘username1’
Get-ADDomainController -fi * | select -exp hostname | % {
$GweParams = @{
‘Computername’ = $_
‘LogName’ = ‘Security’
‘FilterXPath’ = "*[System[EventID=4740] and EventData[Data[@Name='TargetUserName']='$Username']]"
}
$Events = Get-WinEvent @GweParams
$Events | foreach {$_.Computer + " " +$_.Properties[1].value + ' ' + $_.TimeCreated}
}