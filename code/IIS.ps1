# Skript for installering av IIS-rolle og nedlasting av webside.
# Noen deler hentet fra tidligere studenter:
# https://github.com/Magnussen98/DCSG1005_Infra_Oblig2_ActiveDirectory/blob/master/Scripts/IIS/Install-IIS.ps1

$scriptBlock = {
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/dh-ctrl/draker.no/main/index.html -OutFile C:\inetpub\wwwroot\index.html
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools

}

# Legger server-navn i variabel fordi ComputerName ikke skal hardcodes:
$server = "SRV1"

# Utfører skript på srv1:
Invoke-Command -ComputerName $server -ScriptBlock $scriptBlock