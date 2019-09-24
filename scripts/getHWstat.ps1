######################################################## 
# Get-HwInfo.ps1 
# Version 1.0 
# 
# Getting basic information about systems hardware 
# 
# Vadims Podans (c) 2008 
# http://vpodans.spaces.live.com/ 
########################################################

function Get-HwInfo ($computers = ".") {
    $OS = gwmi  Win32_OperatingSystem -ComputerName $computers | Select Caption, OSArchitecture,
        OtherTypeDescription, ServicePackMajorVersion, CSName, TotalVisibleMemorySize
    $CPU = gwmi  Win32_Processor -ComputerName $computers | Select Architecture, DeviceID, Name
    $RAM = gwmi  Win32_MemoryDevice -ComputerName $computers | Select DeviceID,
        StartingAddress, EndingAddress
    $MB = gwmi  Win32_BaseBoard -ComputerName $computers | Select Manufacturer, Product, Version
    $VGA = gwmi  Win32_VideoController -ComputerName $computers | Select Name, AdapterRam
    $HDD = gwmi  Win32_DiskDrive -ComputerName $computers | select Model, Size
    $Volumes = gwmi  Win32_LogicalDisk -Filter "MediaType = 12" -ComputerName $computers | Select DeviceID,
        Size, FreeSpace
    $CD = gwmi Win32_CDROMDrive | Select Id, Name, MediaType
    $NIC = gwmi Win32_NetworkAdapter -ComputerName $computers | ?{$_.NetConnectionID -ne $null}
    Write-Host "Computer Name: `n`t" $OS.CSName `
    `n"Operating System: `n`"
 $OS.Caption  "  $OS.OtherTypeDescription $OS.OSArchitecture ` 
   `nService Pack: `n`" Service
 Pack OS.ServicePackMajorVersion " in installed `    `nProcessors:
    $CPU | ft DeviceID, @{
        Label = Architecture; Expression = {
            switch ($_.Architecture) {
                0 {x86}; 1 {MIPS}; 2 {Alpha}; 3 {PowerPC}; 6 {Intel
 Itanium}; 9 {x64}
            }
        }
    }, @{Label = Model; Expression = {$_.name}} -AutoSize
    Write-Host Physical Memory:   $RAM | ft DeviceID, @{Label = "ModuModule Size(MB)xpression = {
        (($_.endingaddress - $_.startingaddress) / 1KB).tostring("F00"F00)}} -AutoSize
    Write-Host Total Memory: `n`"
 ($OS.TotalVisibleMemorySize / 1KB).tostring() " M)  `
   ` 
   `nMotherBoard: 
 ` 
   `n`Vendor: 
 $MB.Manufacturer ` 
   `n`Model:  
 $MB.Product ` 
   `n`Version: 
 $MB.Version ` 
   `nVideocontroller:
 ` 
   `n`Model: 
 $VGA.Name ` 
   `n`Video RAM: 
 ($VGA.AdapterRam/1MB).tostring(B`n" )     `n" ` 
   `nHarddDisks:

    $HDD | ft Model, @{Label=(GB)"; Expressi; Expression = {($_.Size/1GB).tostring(AutoS)}} -AutoSize
    Write-Host itions:"
    $Volu
    $Volumes | ft DeviceID, @{Label=(GB)"; Expressi; Expression={($_.Size/1GB).ToString(     )}},
        @{Label=GB)"; Expressi; Expression={($_.FreeSpace/1GB).tostring(AutoS)}} -AutoSize
    $CD | ft Id, @{Label = e"; Expressi; Expression = {$_.MediaType}},
        @{Label = xpressi; Expression = {$_.Name}} -AutoSize
    Write-Host apters:"
    $NIC 
    $NIC | ft NetConnectionID, @{
        Label=tus"; Expressi; Expression = {
            switch ($_.NetConnectionStatus) {
                onn {ted"}
        }
                ect {g"}
        }
                ect {"}
        }
                onn {ting"}
        }
                war {not present"}
        }
                war {disabled"}
        }
                war {malfunction"}
        }
                a d {connected"}
        }
                ent {ating"}
        }
                ent {ation succeeded"}
        }
                hent {ation failed"}
        }
                alid {ddress"}
        }
                dent {ls required"}
        }
            }
        }
    }, @{Label=ressi; Expression={$_.name}}
}