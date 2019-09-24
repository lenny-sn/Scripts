#������� ������ �������� ������� ����� � ����
Filter Where-Online
{
    $ping = new-object System.Net.NetworkInformation.Ping
    trap {Write-Verbose "ping error"; Continue}
    if ($ping.send($_).Status -eq "Success" ) { $_ }
}

$Comp_list=@{}

#�������� ����� �� ������ OU � AD
$comp_arr= Get-QADComputer -SearchRoot "ou=test, ou=workstations, ou=wsus_computers,dc=moscow,dc=domainname,dc=ru"  | foreach {$_.dnsname} | where-online

#�������� � ����
foreach ($pc in $comp_arr) 
    {
        #������ � WMI ��������� �����
        $CS = Gwmi Win32_ComputerSystem -Comp $pc
        "Machine Name: " + $CS.Name
        "Logged On User: " + $CS.UserName
        
        #������� ������ � ��� �������
        $Comp_list[$CS.Name] = new-object System.Management.Automation.PSObject
        
        $Comp_list[$CS.Name] | add-member noteproperty CompName $CS.Name
        $Comp_list[$CS.Name] | add-member noteproperty User $CS.UserName
    }
    
#��������� � CSV
$Comp_list | select -expand values| export-csv "d:\temp\exp.csv" -Encoding Unicode  