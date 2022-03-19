# Skript for oppretting av OUer.
Import-Module activedirectory

Set-Location C:\Users\Administrator\Documents

# Henter csv-fil:
Invoke-WebRequest -URI https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/CSV/ou.csv -OutFile C:\Users\Administrator\Documents\ou.csv

#Sjekker om filen finnes:
if ((Get-Item ou.csv).Exists) {
    # # Inspirert av:
    # https://activedirectorypro.com/create-bulk-organizational-units-ou-in-active-directory-with-powershell/
    # Leser og oppretter OUer fra csv-fil (header: name;path;description):
    $ADOU = Import-csv C:\Users\Administrator\Documents\ou.csv -Delimiter ";"
    foreach ($ou in $ADOU) {
        New-ADOrganizationalUnit `
        -Name $ou.name `
        -Path $ou.path `
        -Description $ou.description `
    }
} else {
    Write-Output "Filen finnes ikke"}

