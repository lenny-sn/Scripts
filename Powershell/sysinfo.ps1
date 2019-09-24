"Operating System" >> c:\temp\config.txt
Get-WmiObject -Class Win32_OperatingSystem | Select Codeset, SerialNumber,
Version, Manufacturer, Locale, FREE | Out-File -Append -FilePath c:\temp\config.txt
"Computer System" >> c:\temp\config.txt
Get-WmiObject -Class Win32_ComputerSystem |
Select Name, Manufacturer, Model, CurrentTimeZone,
TotalPhysicalmemory | Out-File -Append -FilePath c:\temp\config.txt
"Processor" >> c:\temp\config.txt
Get-WmiObject -Class Win32_Processor | select Name, Caption, DeviceID, Status, NumberOfCores, ProcessorId  |
Out-File -Append -FilePath c:\temp\config.txt
"BIOS" >> c:\temp\config.txt
Get-WmiObject -Class Win32_Bios |
Select -Property BuildNumber, CurrentLanguage,
InstallableLanguages, Manufacturer, Name,
PrimaryBIOS, ReleaseDate, SerialNumber,
SMBIOSBIOSVersion, SMBIOSMajorVersion,
SMBIOSMinorVersion, SMBIOSPresent, Status,
Version, BiosCharacteristics | Out-File -Append -FilePath c:\temp\config.txt
"-------------------------------------------------------------------------------------------------------------------------" >> c:\temp\config.txt
