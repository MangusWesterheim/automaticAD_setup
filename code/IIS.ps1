###################################################################################
# Dette skriptet installerer IIS-rollen og laster ned webside, på SRV1            #
#                                                                                 #
###################################################################################

$scriptBlock = {
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/dh-ctrl/draker.no/main/index.html -OutFile C:\inetpub\wwwroot\index.html
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools

}

$server = "SRV1"

# Utfører skript på srv1:
Invoke-Command -ComputerName $server -ScriptBlock $scriptBlock