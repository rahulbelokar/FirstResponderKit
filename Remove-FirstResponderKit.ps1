Function Remove-FirstResponderKit 
{
    Param (
               [String]$ServerName = $env:COMPUTERNAME,
               [String]$scriptPath = $PSScriptRoot+'\Remove-FirstResponderKit'
          )

    $blitzScriptFiles = Get-ChildItem -Path $scriptPath | Where-Object -Property Extension -EQ '.sql';
    
    foreach ($scriptFile in $blitzScriptFiles)
    {
        try 
        {
            Write-Host "Dropping sp_Blitz scripts from [$ServerName] server.";            
            Invoke-Sqlcmd -ServerInstance $ServerName -InputFile $scriptFile.FullName | Out-File -FilePath "$($scriptFile.Directory)\$($scriptFile.BaseName)__OUTPUT.txt"
        }
        catch
        {
            Write-Host "        Error occurred" -BackgroundColor Yellow -ForegroundColor Red 
        }
    }
}