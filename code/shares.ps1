# Skript som Oppretter shares mappene og sharer de med de som skal ha tilgang til de
#

# Henter en csv fil med mappestrukturen og lager strukturen
Set-Location C:\
Invoke-WebRequest https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/CSV/ShareFolders.csv -OutFile C:\shares.csv
$Folders = Get-Content -Path C:\shares.csv
mkdir -path $Folders

# Lager shares mapper til alle avdelingene
New-SmbShare -Name "\\SRV1\contoso" -Path "C:\Shares\Contoso" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\dept\it" -Path "C:\Shares\Dept\IT" -FullAccess "file_it"
New-SmbShare -Name "\\SRV1\dept\admin\finance" -Path "C:\Shares\Dept\Admin\Finance" -FullAccess "file_adm_finance"
New-SmbShare -Name "\\SRV1\dept\admin\hr" -Path "C:\Shares\Dept\Admin\HR" -FullAccess "file_adm_hr"
New-SmbShare -Name "\\SRV1\dept\admin\logistics" -Path "C:\Shares\Dept\Admin\Logistics" -FullAccess "file_adm_logistics"
New-SmbShare -Name "\\SRV1\dept\admin\management" -Path "C:\Shares\Dept\Admin\Management" -FullAccess "file_adm_management"
New-SmbShare -Name "\\SRV1\dept\admin\marketing" -Path "C:\Shares\Dept\admin\marketing" -FullAccess "file_adm_marketing"
New-SmbSHare -Name "\\SRV1\software" -Path "C:\Software" -ReadAccess "file_contoso" -FullAccess "dl_it_client_localadm"

# Oppretter shares til UserProfiles mappen
New-SmbShare -Name "\\SRV1\userprofiles\contacs" -Path "C:\UserProfiles\Contacts" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\desktop" -Path "C:\UserProfiles\Desktop" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\documents" -Path "C:\UserProfiles\Documents" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\downloads" -Path "C:\UserProfiles\Downloads" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\favorites" -Path "C:\UserProfiles\Favorites" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\links" -Path "C:\UserProfiles\Links" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\music" -Path "C:\UserProfiles\Music" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\pictures" -Path "C:\UserProfiles\Pictures" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\startmenu" -Path "C:\UserProfiles\StartMenu" -FullAccess "file_contoso"
New-SmbShare -Name "\\SRV1\userprofiles\videos" -Path "C:\UserProfiles\Videos" -FullAccess "file_contoso"


