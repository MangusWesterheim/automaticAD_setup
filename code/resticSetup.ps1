<#
    .SYNOPSIS
    Restic-oppsett som tar sikkerhetskopi av alle brukerprofiler og shares hver natt kl 02.00 til Swift. Snapshot som er eldre enn 14 dager blir slettet.
    Prune-skript kjøres hver søndag kl 19:00 og rydder opp i repositoryet.
#>

$source = 'https://github.com/restic/restic/releases/download/v0.12.1/restic_0.12.1_windows_amd64.zip'
New-item -Path C:\Temp -ItemType Directory -Force
$destination = 'C:\Temp\Restic.zip'
$path = "C:\Scripts"
Invoke-WebRequest -Uri $source -OutFile $destination
New-item -Path $path -ItemType Directory -Force
Expand-Archive -LiteralPath $destination -destinationPath $path -Force

# Backup-skript innhold
$createBackupScript = @'
$env:RESTIC_PASSWORD=’xUGH3So*>w@$ZWnP’
$env:OS_AUTH_TYPE=’v3applicationcredential’
$env:OS_AUTH_URL=’https://api.skyhigh.iik.ntnu.no:5000/v3’
$env:OS_IDENTITY_API_VERSION=’3’
$env:OS_REGION_NAME="SkyHiGh"
$env:OS_INTERFACE=’public’
$env:OS_APPLICATION_CREDENTIAL_ID=’b7b55d3361324e9e91b5f9da0dcb7af6’
$env:OS_APPLICATION_CREDENTIAL_SECRET=’oiOKEkJ0RfrtC9d-tSVTVnboz7USDZeMZcixAe9iLmD3um0HJW2StCJbrpdP3qgEvmZB93-pLsDlNVRd-frpJA’
$excludefile = ’C:\scripts\excludes.txt’

#Set date in logfiles
Write-Output "------------------------------------" | Tee-Object C:\Scripts\restic.log -Append
(Get-Date).DateTime  | Tee-Object C:\Scripts\restic.log -Append
Write-Output "------------------------------------" | Tee-Object C:\Scripts\restic.log -Append

#Backups Restic Repo
.\restic_0.12.1_windows_amd64.exe -r swift:ResticBackup:/ backup C:\Shares --exclude-file=$excludefile --use-fs-snapshot | Tee-Object C:\Scripts\restic.log -Append
.\restic_0.12.1_windows_amd64.exe -r swift:ResticBackup:/ backup C:\UserProfiles --exclude-file=$excludefile --use-fs-snapshot | Tee-Object C:\Scripts\restic.log -Append
.\restic_0.12.1_windows_amd64.exe -r swift:ResticBackup:/ forget --keep-last 14 | Tee-Object C:\Scripts\restic.log -Append

Remove-Item Env:\RESTIC_PASSWORD
Remove-Item Env:\OS_APPLICATION_CREDENTIAL_SECRET

'@
# Prune-skript innhold
$createPruneScript = @'

$env:RESTIC_PASSWORD=’xUGH3So*>w@$ZWnP’
$env:OS_AUTH_TYPE=’v3applicationcredential’
$env:OS_AUTH_URL=’https://api.skyhigh.iik.ntnu.no:5000/v3’
$env:OS_IDENTITY_API_VERSION=’3’
$env:OS_REGION_NAME="SkyHiGh"
$env:OS_INTERFACE=’public’
$env:OS_APPLICATION_CREDENTIAL_ID=’b7b55d3361324e9e91b5f9da0dcb7af6’
$env:OS_APPLICATION_CREDENTIAL_SECRET=’oiOKEkJ0RfrtC9d-tSVTVnboz7USDZeMZcixAe9iLmD3um0HJW2StCJbrpdP3qgEvmZB93-pLsDlNVRd-frpJA’

#Set date in logfiles
Write-Output "------------------------------------" | Tee-Object C:\Scripts\restic-prune.log -Append
(Get-Date).DateTime  | Tee-Object C:\Scripts\restic-prune.log -Append
Write-Output "------------------------------------" | Tee-Object C:\Scripts\restic-prune.log -Append
#Prunes Restic Repo
.\restic_0.12.1_windows_amd64.exe -r swift:ResticBackup:/ prune | Tee-Object restic-prune.log -Append

Remove-Item Env:\RESTIC_PASSWORD
Remove-Item Env:\OS_APPLICATION_CREDENTIAL_SECRET

'@


# exludes.txt innhold
$createExcludes = @'
    # default excludes
    # examples https://github.com/duplicati/duplicati/blob/master/Duplicati/Library/Utility/FilterGroups.cs
    C:\hiberfil.sys
    C:\pagefile.sys
    C:\swapfile.sys
    C:\$Recycle.Bin
    C:\autoexec.bat
    C:\Config.Msi
    C:\Documents and Settings
    C:\Recycled
    C:\Recycler
    C:\$$Recycle.Bin
    C:\System Volume Information
    C:\Recovery
    C:\Program Files
    C:\Program Files (x86)
    C:\ProgramData
    C:\PerfLogs
    C:\Windows
    C:\Windows.old
    C:\$$WINDOWS.~BT
    C:\$$WinREAgent
    Microsoft\Windows\Recent
    Microsoft\**\RecoveryStore*
    Microsoft\**\Windows\*.edb
    Microsoft\**\Windows\*.log
    Microsoft\**\Windows\Cookies*
    MSOCache
    NTUSER*
    ntuser*
    UsrClass.dat

    # cloud services
    Dropbox
    AppData\Local\Google\Drive
    Google Drive\.tmp.drivedownload
    C:\OneDriveTemp

    # browsers
    Google\Chrome

    # AppData
    AppData\Local\Microsoft
    AppData\Local\Duplicati
    AppData\Local\D3DSCache
    AppData\Local\ConnectedDevicesPlatform
    AppData\Local\Packages
    AppData\Roaming\Signal
    AppData\Local\ElevatedDiagnostics
    AppData\Local\Microsoft\Windows\Explorer
    AppData\Local\Microsoft\Windows\INetCache
    AppData\Local\Microsoft\Windows\WebCache
    AppData\Local\Microsoft\Windows Store
    AppData\Local\restic
    AppData\LocalLow\Microsoft\CryptnetUrlCache
    AppData\Local\IsolatedStorage
    AppData\Local\Spotify
    AppData\Local\Programs\signal-desktop
    AppData\Roaming\Code
    AppData\Roaming\Slack
    AppData\Roaming\Spotify
    AppData\Roaming\Zoom

    # misc. temporary files
    Temporary Internet Files
    Thumbs.db
    AppData\Local\Temp
    Users\Public\AccountPictures
'@

# Lag filer
$createExcludes > C:\Scripts\excludes.txt
$createBackupScript > C:\Scripts\backupScript.ps1
$createPruneScript > C:\Scripts\backupPrune.ps1


schtasks /CREATE  /ru "SYSTEM" /tn "Restic Backups" /tr "powershell.exe -file C:\Scripts\backupScript.ps1" /sc daily /st 02:00 /F
schtasks /CREATE  /ru "SYSTEM" /tn "Restic Prune" /tr "powershell.exe -file C:\Scripts\backupPrune.ps1" /sc weekly /d sun /st 19:00 /F

# Sett filtilganger
$FolderACL  = Get-Acl $path
$FolderACL.SetAccessRuleProtection($true,$true)
Set-Acl $path -AclObject $FolderACL

icacls $path /grant CORP\file_it_scripts:F
icacls $path /remove BUILTIN\Users /t /c