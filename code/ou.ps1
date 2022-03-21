#Requires -RunAsAdministrator

#############################################################################################################
# Dette skriptet importerer OUer fra en CSV-fil og oppretter de deretter til i AD.                          #
# CSV-filen må inneholde parameterne name, path, og description.                                            #
# Inspirert av skript fra:                                                                                  #
# https://activedirectorypro.com/create-bulk-organizational-units-ou-in-active-directory-with-powershell/   #
#                                                                                                           #
#############################################################################################################

#Requires -RunAsAdministrator

Import-Module activedirectory

# Henter CSV-fil:
Invoke-WebRequest -URI https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/CSV/ou.csv -OutFile ou.csv

# Sjekker om filen finnes:
if ((Get-Item ou.csv).Exists) {

    # Leser og oppretter OUer fra CSV-fil (header: name;path;description):
    $ADOU = Import-csv ou.csv -Delimiter ";"
    foreach ($ou in $ADOU) {
        New-ADOrganizationalUnit `
        -Name $ou.name `
        -Path $ou.path `
        -Description $ou.description `
    }
} else {
    Write-Output "Finner ikke ou-skriptet." }
