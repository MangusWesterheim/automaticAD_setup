# Noen deler hentet fra tidligere studenter:
# https://github.com/Magnussen98/DCSG1005_Infra_Oblig2_ActiveDirectory/blob/master/Scripts/IIS/Install-IIS.ps1

Set-Location "$home\Downloads"

# Laster ned html fra webside:
Invoke-WebRequest -Uri https://raw.githubusercontent.com/dh-ctrl/draker.no/main/index.html -OutFile index.html


# Script for installering av IIS-rolle og legger websiden i riktig mappe:
$scriptBlock = {
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    Copy-Item -Path  "index.html" -Destination "C:\inetpub\wwwroot" -Recurse -Force
}

# Utføres på srv1:
Invoke-Command -ComputerName "srv1" -ScriptBlock $scriptBlock



