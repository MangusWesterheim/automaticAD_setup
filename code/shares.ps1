#Requires -RunAsAdministrator

######################################################################################
# Skript som Oppretter shares mappene og sharer de med de som skal ha tilgang til de #
#                                                                                    #
######################################################################################

# Skript som Oppretter shares mappene og sharer de med de som skal ha tilgang til de


# Henter en csv fil med mappestrukturen og lager strukturen
Set-Location C:\
Invoke-WebRequest https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/CSV/ShareFolders.csv -OutFile C:\shares.csv
$Folders = Get-Content -Path C:\shares.csv
mkdir -path $Folders

# Lager shares mapper til alle avdelingene
New-SmbShare -Name "Contoso" -Path "C:\Shares\Contoso" -FullAccess "CORP\file_contoso"
New-SmbShare -Name "IT" -Path "C:\Shares\Dept\IT" -FullAccess "CORP\file_it"
New-SmbShare -Name "Finance" -Path "C:\Shares\Dept\Admin\Finance" -FullAccess "CORP\file_adm_finance"
New-SmbShare -Name "HR" -Path "C:\Shares\Dept\Admin\HR" -FullAccess "CORP\file_adm_hr"
New-SmbShare -Name "Logistics" -Path "C:\Shares\Dept\Admin\Logistics" -FullAccess "CORP\file_adm_logistics"
New-SmbShare -Name "Management" -Path "C:\Shares\Dept\Admin\Management" -FullAccess "CORP\file_adm_management"
New-SmbShare -Name "Marketing" -Path "C:\Shares\Dept\admin\marketing" -FullAccess "CORP\file_adm_marketing"
New-SmbSHare -Name "Software" -Path "C:\Software" -ReadAccess "CORP\file_contoso" -FullAccess "CORP\file_it_softwareDistribution"

# Oppretter shares til UserProfiles mappen
New-SmbShare -Name "Contacts" -Path "C:\UserProfiles\Contacts" -FullAccess "Everyone"
New-SmbShare -Name "Desktop" -Path "C:\UserProfiles\Desktop" -FullAccess "Everyone"
New-SmbShare -Name "Documents" -Path "C:\UserProfiles\Documents" -FullAccess "Everyone"
New-SmbShare -Name "Downloads" -Path "C:\UserProfiles\Downloads" -FullAccess "Everyone"
New-SmbShare -Name "Favorites" -Path "C:\UserProfiles\Favorites" -FullAccess "Everyone"
New-SmbShare -Name "Links" -Path "C:\UserProfiles\Links" -FullAccess "Everyone"
New-SmbShare -Name "Music" -Path "C:\UserProfiles\Music" -FullAccess "Everyone"
New-SmbShare -Name "Pictures" -Path "C:\UserProfiles\Pictures" -FullAccess "Everyone"
New-SmbShare -Name "StartMenu" -Path "C:\UserProfiles\StartMenu" -FullAccess "Everyone"
New-SmbShare -Name "Videos" -Path "C:\UserProfiles\Videos" -FullAccess "Everyone"