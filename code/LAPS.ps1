###########################################################################################################################################################################
# Dette skriptet installerer Local Administrator Password Solution (LAPS), et program som muliggjør administrasjon av innebygde Administrator-kontoer på Windows-maskiner.
# Passordene kan bli lagret i AD og beskyttet med ACL, slik at kun godkjente brukere kan hente ut og tilbakestille passordene.
#
# VIKTIG: Skriptet oppdaterer Schema, slik at rollen som Schemaadministrator er påkrevet for å oppdatere AD.
#
# https://www.mczerniawski.pl/laps/deploy-laps-with-powershell/
#
###########################################################################################################################################################################

#Requires -RunAsAdministrator


$user = [Environment]::UserName;
$members = Get-ADGroupMember -Identity "Schema Admins" -Recursive | Select-Object -ExpandProperty Name
$URLs = @('https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/LAPS.x64.msi','https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/LAPS.x86.msi')
$DownloadFolder = "\\SRV1\Software\LAPS"

## Sjekker at nettverksbane er tilgjengelig og at bruker har riktige tilganger.
if (Test-Path -Path "\\SRV1\Software")  {
    if ($members -contains $user) {
        ## Laster ned LAPS og legger det til banen
        New-Item -Path $DownloadFolder -ItemType Directory -Force
        $URLs | foreach-object {

            $fileName = Split-Path $_ -Leaf
            $DestinationPath = Join-Path $DownloadFolder -ChildPath $fileName
            Invoke-WebRequest -Uri $_ -OutFile $DestinationPath
        }
        ## Installerer LAPS på DC og legger til ADMX template
        Start-Process "msiexec" -ArgumentList "/i $DownloadFolder\LAPS.x64.msi ADDLOCAL=Management.UI,Management.PS,Management.ADMX /quiet /norestart" -Wait -NoNewWindow -PassThru

        ## Oppdaterer Schema og konfigurer LAPS-rettigheter
        Import-Module AdmPwd.PS
        Update-AdmPwdADSchema
        Set-AdmPwdReadPasswordPermission -OrgUnit "OU=Clients,DC=corp,DC=contoso,DC=com" -AllowedPrincipals "dl_it_client_laps_read"
        Set-AdmPwdResetPasswordPermission -OrgUnit "OU=Clients,DC=corp,DC=contoso,DC=com" -AllowedPrincipals "dl_it_client_laps_reset"
        Set-AdmPwdReadPasswordPermission -OrgUnit "OU=Servers,DC=corp,DC=contoso,DC=com" -AllowedPrincipals "dl_it_server_laps_read"
        Set-AdmPwdResetPasswordPermission -OrgUnit "OU=Servers,DC=corp,DC=contoso,DC=com" -AllowedPrincipals "dl_it_server_laps_reset"

        Copy-Item -Recurse -Path C:\Windows\PolicyDefinitions\* -Destination C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions -Force
    } else {
        Write-Output "Ingen endringer utført. Du er ikke med i Schema Admins gruppen. Vennligst sjekk tilganger!"
    }
}
else {
    Write-Output "Ingen endringer utført. Nettverksbane ble ikke funnet!"
}






