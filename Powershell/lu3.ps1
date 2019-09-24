$i=-1;$b="$args";
$a=(Get-ADDomain).ReplicaDirectoryServers;
$a | % { $i++; trap {"No such user in AD"; continue} get-aduser -Server $_ -identity "$b" -Properties *  |
select @{n="AD Controller"; e={$a[$i]}}, name, displayname, enabled, passwordexpired, passwordlastset, Modified, lockedout, AccountLockoutTime, badlogoncount, badpwdcount, LastBadPasswordAttempt, LastLogonDate, AccountExpirationDate
} | Out-GridView