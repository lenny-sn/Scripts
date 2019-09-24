$a=get-addomaincontroller -Service PrimaryDC -Discover;
get-aduser -Server $a.name -identity "$args" -Properties * | fl name, displayname, enabled, passwordexpired, passwordlastset, Modified, lockedout, AccountLockoutTime, badlogoncount, badpwdcount, LastBadPasswordAttempt, LastLogonDate, AccountExpirationDate;
"PDC Controller: $a"