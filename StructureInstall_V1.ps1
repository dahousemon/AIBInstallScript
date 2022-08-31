#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region Start Copy of ISO from Azure Fileshare
#C:\temp\azcopy cp "https://bladesawstorage.blob.core.windows.net/isostrorage?sp=racwdl&st=2022-08-31T14:57:49Z&se=2023-04-29T22:57:49Z&spr=https&sv=2021-06-08&sr=c&sig=QLoOcXsW3C2BttXEgCpzyE2ELAKDBpq6nj4reg3jBNU%3D" "C:\Temp\ISO" --recursive=true
#endregion




#Mount The downloaded ISO on the VM
#mount-diskimage -ImagePath "C:\temp\ISO\isostrorage\ISO\MiTekSuite_8.6.0.209_US.iso" 



#region Structure 
try {
    Start-Process -filepath 'F:\Programs\InitialSetup\setup.exe' -ArgumentList '/z"MBA=true;Path=C:\MiTek;Folder=MiTek;SQLName=(local)\MII;DBName=MII;"'
    if (Test-Path "C:\MiTek\Programs\UI.exe") {
        Write-Log "Structure has been installed"
    }
    else {
        write-log "Error locating the Structure  executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
   # write-log "Error installing Structure : $ErrorMessage"
}
#endregion