Function Write-FileLog {
       
    <#
    .SYNOPSIS 
    Script writes array of strings to log file, if log file does not exist  tries to create new file at the selected path.    
    Also it can skip Null strings and write info before and after string. 
    Script is able to fill file logs and write an output to console simultaneously. 
 
 
    .PARAMETER Value 
    This parameter takes array of strings, basicaly by pipeline 
 
 
    .PARAMETER Logname 
    Log will be written in this file. If file does not exist, it will be created.  
    If file exists, log will be appended 
        Syntax.: "C:\temp\text.log" 
 
 
    .PARAMETER AddAtBegin 
    Parameter will be helpful if you need to add something at the beginning of every string, 
    for example: date and time, or some trigers. 
        Ex.: "String1`r`nString2" | Write-FileLog -AddAtBegin "$(get-date -UFormat '%d.%m.%Y %H:%m:%S')   : " ` 
            -OutOnScreen -Logname C:\temp\text.log 
        Out: 29.01.2017 12:01:26   : String1 
             29.01.2017 12:01:26   : String2 
 
    .PARAMETER AddToEnd 
    The same as the AddAtBegin parameter, but value from this parameter will be added at the end of the string. 
 
 
    .PARAMETER AddAtBeginRegOut 
    The same as AddAtBegin parameter but work with OutRegexpMask switch.  
    Parameter will work only if parameter OutRegexpMask is turned on and string matches to selected Regexp 
    If string does not match to OutRegexpMask, then parameter AddAtBegin will work.  
        Ex.: "String1`r`nString2" | Write-FileLog -Logname C:\temp\text.log ` 
                -AddAtBegin "$(get-date -UFormat '%d.%m.%Y %H:%m:%S')   : " ` 
                -OutRegexpMask '1$'-AddAtBeginRegOut "REGEXP Succesfully match at this string '" -AddToEndRegOut "'" 
             Get-Content C:\temp\text.log 
 
        Console: REGEXP Succesfully match at this string 'String1' 
         
        File:  
            REGEXP Succesfully match at this string 'String1' 
            29.01.2017 14:01:55   : String2 
     
     
    .PARAMETER AddToEndRegOut 
    The same as AddToEnd parameter but work with OutRegexpMask switch.  
    Parameter will work only if parameter OutRegexpMask is turned on and string matches to selected Regexp 
    If string does not match to OutRegexpMask, then parameter AddToEnd will work.   
         
         
    .PARAMETER SkipNullString 
    If you do not need to see blank (null) string in the output, turn this parameter on. 
        EX.: "String1`r`n`r`nString2" | Write-FileLog -SkipNullString -OutOnScreen -Logname C:\temp\text.log 
        Out: String1 
             String2 
 
 
    .PARAMETER OutOnScreen 
    If this switch parameter is chosen, text will be outputted in a file and on screen 
 
 
    .PARAMETER OutRegexpMask 
    Regexp trigger to write out some strings to console. (Read descriptions of AddAtBeginRegOut and AddToEndRegOut parameters as well). 
 
     
    .EXAMPLE 
    Get-ChildItem C:\temp | Out-String | Write-FileLog -OutOnScreen -Logname C:\temp\text.log 
     
     
    VERBOSE: 
    -------- 
        Directory: C:\temp 
 
 
    Mode                LastWriteTime     Length Name 
    ----                -------------     ------ ---- 
    -a---        29.01.2017     14:19       3182 text.log                          
 
 
    Description 
    ----------- 
    The same as Out-File, but with output on console 
          
 
    .EXAMPLE 
    Get-ChildItem C:\temp | Out-String | Write-FileLog -OutOnScreen -Logname C:\temp\text.log -SkipNullString 
     
     
    VERBOSE: 
    -------- 
        Directory: C:\temp 
    Mode                LastWriteTime     Length Name 
    ----                -------------     ------ ---- 
    -a---        29.01.2017     14:19       3182 text.log 
 
 
    Description 
    ----------- 
    There are two blank strings between strings started with "Directory: ..." and "Mode ..." in previous Example , and parameter -SkipNullString removed them. 
 
 
 
    .NOTES 
        Name:  Write-FileLog 
        Version: 1.0 
        Author: Vector BCO 
        DateCreated: 29 Jan 2017 
        Link: https://gallery.technet.microsoft.com/Write-FileLog-Redirect-a91cdc2f
    #>
    
    Param (
        [parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        [AllowEmptyString()]
        [AllowNull()]
            [String[]]$Value,
        [parameter(Mandatory=$true,
            Position=1)]
        [alias("File","Filename","FullName")]
        [ValidateScript({
            If (Test-Path $_){
                -NOT ((Get-Item $_).Attributes -like "*Directory*")
            }
            ElseIf (-NOT (Test-Path $_)){
                $Tmp = $_
                $Tmp -match '(?''path''^\w\:\\([^\\]+\\)+)(?''filename''[^\\]+)' | Out-Null
                $TmpPath = $Matches['path']
                $Tmpfilename = $Matches['filename']
                New-Item -ItemType Directory $TmpPath -Force -ErrorAction Stop
                New-Item -ItemType File $TmpPath$Tmpfilename -ErrorAction Stop
            } # End ElseIf blockk
        })] # End validate script
            [String]$Logname,
        [String]$AddAtBegin,
        [String]$AddToEnd,
        [String]$AddAtBeginRegOut,
        [String]$AddToEndRegOut,
        [switch]$SkipNullString,
        [switch]$OutOnScreen,
        [String]$OutRegexpMask
    ) # End Func block
    begin {}
    process {
        $Value -split '\n' | foreach {

            If ($SkipNullString -and (-not (([string]::IsNullOrEmpty($($_))) -or ([string]::IsNullOrWhiteSpace($($_)))))){
                if ([String]::IsNullOrEmpty($OutRegexpMask)){
                    If ($OutOnScreen){"$AddAtBegin$($_ -replace '\r')$AddToEnd"}
                    "$AddAtBegin$($_ -replace '\r')$AddToEnd" | out-file $Logname -Append
                } # End If
                elseif (![String]::IsNullOrEmpty($OutRegexpMask)){
                    If ($($_ -replace '\r') -match $OutRegexpMask){
                        "$AddAtBeginRegOut$($_ -replace '\r')$AddToEndRegOut"
                        "$AddAtBeginRegOut$($_ -replace '\r')$AddToEndRegOut" | out-file $Logname -Append
                    } # End If
                    Else {
                        "$AddAtBegin$($_ -replace '\r')$AddToEnd" | out-file $Logname -Append
                    }
                } # End elseif
            } # End If
            ElseIF (-not ($SkipNullString)){
                if ([String]::IsNullOrEmpty($OutRegexpMask)){
                    If ($OutOnScreen){"$AddAtBegin$($_ -replace '\r')$AddToEnd"}
                    "$AddAtBegin$($_ -replace '\r')$AddToEnd" | out-file $Logname -Append
                } # End If
                elseif (![String]::IsNullOrEmpty($OutRegexpMask)){
                    If (($($_ -replace '\r') -match $OutRegexpMask) -or ([string]::IsNullOrEmpty($($_))) -or ([string]::IsNullOrWhiteSpace($($_)))){
                        "$AddAtBeginRegOut$($_ -replace '\r')$AddToEndRegOut"
                        "$AddAtBeginRegOut$($_ -replace '\r')$AddToEndRegOut" | out-file $Logname -Append
                    } # End If
                    Else {
                        "$AddAtBegin$($_ -replace '\r')$AddToEnd" | out-file $Logname -Append
                    } # End Else
                } # End elseif
            } # End elseif
        } # End Foreach
    } # End process
    end {}
} # End Function