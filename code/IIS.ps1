###################################################################################
# Dette skriptet installerer IIS-rollen og laster ned webside, på SRV1            #
#                                                                                 #
###################################################################################

$scriptBlock = {
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/dh-ctrl/draker.no/main/index.html -OutFile C:\inetpub\wwwroot\index.html
}

$server = "SRV1"

# Utfører skript på srv1:
Invoke-Command -ComputerName $server -ScriptBlock $scriptBlock