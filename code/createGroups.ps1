######################################################################################
# Dette skriptet importerer grupper fra en CSV-fil og legger det deretter til i AD.  #
# CSV-filen må inneholde parameterne Name, Path, Scope, Category og Description.     #
# Det legger så til folk i riktige grupper utifra avdeling og stilling.              #
#                                                                                    #
######################################################################################

#Requires -RunAsAdministrator

Import-Module ActiveDirectory

# Henter CSV-fil:
Invoke-WebRequest -URI https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/CSV/groups.csv -OutFile groups.csv

# Sjekker om CSV er tilgjenglig og importerer
if (Test-Path -Path groups.csv) {
    $groups = Import-Csv ‘groups.csv‘ -Delimiter ";"

    foreach ($group in $groups) {
      $groupProperties  = @{
          Name          = $group.name
          Path          = $group.path
          GroupScope    = $group.scope
          GroupCategory = $group.category
          Description   = $group.description
    }

    New-ADGroup @groupProperties

    }
    Write-Output "Grupper ble lagt til!"
}
else {
    Write-Output "CSV-fil ble ikke funnet. Sjekk filnavn!"
}

# Legger til brukere i grupper baset på avdeling og stilling:
$ADGroup = 'dl_it_client_localadm'
Get-ADUser -Filter 'Department -eq "IT"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_resetPassword'
Get-ADUser -Filter 'Department -eq "IT"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_client_laps_read'
Get-ADUser -Filter 'Department -eq "IT"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_client_laps_reset'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_server_laps_read'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_server_laps_reset'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_server_localadm'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'dl_it_server_RemoteDesktopUsers'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'G_it_AD-Admin'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_it_scripts'
Get-ADUser -Filter 'Department -eq "IT" -And Description -eq "Server Admin"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_adm_finance'
Get-ADUser -Filter 'Department -eq "Finance"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_it'
Get-ADUser -Filter 'Department -eq "IT"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_it_softwareDistribution'
Get-ADUser -Filter 'Department -eq "IT"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_adm_finance'
Get-ADUser -Filter 'Department -eq "Finance"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_adm_hr'
Get-ADUser -Filter 'Department -eq "HR"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_adm_logistics'
Get-ADUser -Filter 'Department -eq "Logistics"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_adm_management'
Get-ADUser -Filter 'Department -eq "Management"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

$ADGroup = 'file_adm_marketing'
Get-ADUser -Filter 'Department -eq "Marketing"' |
    Where-Object {!($_.memberof -like $ADGroup)} |
    Add-ADPrincipalGroupMembership -MemberOf $ADGroup

Add-ADGroupMember -Identity Administrators -Members G_it_AD-Admin
Add-ADGroupMember -Identity file_it_softwareDistribution -Members Administrator



# Legger til alle brukere i tre grupper:
Get-ADUser -SearchBase ‘OU=AllUsers,DC=corp,DC=contoso,DC=com’ -Filter * |
    ForEach-Object {
        Add-ADGroupMember -Identity ‘file_contoso’ -Members $_
        Add-ADGroupMember -Identity ‘G_active_users’ -Members $_
        Add-ADGroupMember -Identity ‘dl_it_client_RemoteDesktopUsers’ -Members $_
    }