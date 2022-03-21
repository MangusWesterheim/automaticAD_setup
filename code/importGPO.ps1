#####################################################################################################
#  Setter først opp Central Store for Templates og legger til Chrome, Edge og Office-templates her. #
#  Importerer så sikerhetskopierte GPOer og Migration Table inn og oppretter ny gruppepolicyer.     #
#  Linker så disse policyene til korrekte OUer.                                                     #
#####################################################################################################

#Requires -RunAsAdministrator


#Kopierer PolicyDefinitions to Central Store
New-Item -Path C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions -ItemType Directory -Force
Copy-Item -Recurse -Path  C:\Windows\PolicyDefinitions\*  -Destination C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions -Force

##Importerer ADMX-templates til Central Store
$URLs = @('https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/GoogleChromePolicyTemplates.zip','https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/MicrosoftEdgePolicyTemplates.zip','https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/MicrosoftOfficePolicyTemplates.zip')
$DownloadFolder = 'C:\Temp\ADMX'
$Unzip = 'C:\Temp\ADMX\Unzip'
$sysvol = 'C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions'

New-Item -Path $DownloadFolder -ItemType Directory -Force
New-Item -Path $Unzip  -ItemType Directory -Force

 $URLs | foreach-object {
    $fileName = Split-Path $_ -Leaf
    $DestinationPath = Join-Path $DownloadFolder -ChildPath $fileName
    Invoke-WebRequest -Uri $_ -OutFile $DestinationPath
    Expand-Archive -LiteralPath $DownloadFolder\$fileName -DestinationPath $Unzip -Force
    Copy-Item -Recurse -Path $Unzip\*\* -Destination $sysvol -Force
 }


Invoke-WebRequest -URI https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/GPO.zip -OutFile C:\Temp\GPO.zip
Expand-Archive -LiteralPath 'C:\Temp\GPO.zip' -DestinationPath 'C:\Temp\GPO\'-Force


##Importer sikkerhetskopierte GPOer og Migration Table
import-gpo -BackupGpoName CONTOSO-CLIENT_AppLocker -TargetName CONTOSO-CLIENT_AppLocker -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_AuditPolicy -TargetName CONTOSO-CLIENT_AuditPolicy -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_ClientSettings -TargetName CONTOSO-CLIENT_ClientSettings -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_IE_EDGE_CHROME -TargetName CONTOSO-CLIENT_IE_EDGE_CHROME -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_LAPS -TargetName CONTOSO-CLIENT_LAPS -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_LocalAdministrator -TargetName CONTOSO-CLIENT_LocalAdministrator -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_OfficeSettings -TargetName CONTOSO-CLIENT_OfficeSettings -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_RemoteDesktop -TargetName CONTOSO-CLIENT_RemoteDesktop -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_Security -TargetName CONTOSO-CLIENT_Security -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-CLIENT_Firewall -TargetName CONTOSO-CLIENT_Firewall -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded

import-gpo -BackupGpoName CONTOSO-SERVER_AuditPolicy -TargetName CONTOSO-SERVER_AuditPolicy -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-SERVER_Firewall -TargetName CONTOSO-SERVER_Firewall -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-SERVER_Security -TargetName CONTOSO-SERVER_Security -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-SERVER_ServerSettings -TargetName CONTOSO-SERVER_ServerSettings -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-SERVER_LocalAdministrator -TargetName CONTOSO-SERVER_LocalAdministrator -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-SERVER_LAPS -TargetName CONTOSO-SERVER_LAPS -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-SERVER_RemoteDesktop -TargetName CONTOSO-SERVER_RemoteDesktop -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded

import-gpo -BackupGpoName CONTOSO-USER_Desktop_StartMenu_Taskbar_Notifications -TargetName CONTOSO-USER_Desktop_StartMenu_Taskbar_Notifications -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-USER_FolderRedirection -TargetName CONTOSO-USER_FolderRedirection -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-USER_Preferences -TargetName CONTOSO-USER_Preferences -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded
import-gpo -BackupGpoName CONTOSO-USER_DriveMapping -TargetName CONTOSO-USER_DriveMapping -path C:\Temp\GPO\GPO\GPOs -MigrationTable C:\Temp\GPO\GPO\migtable.migtable -CreateIfNeeded

#Link GPO til OU
Get-GPO -Name "CONTOSO-CLIENT_AppLocker" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_AuditPolicy" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_ClientSettings" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_IE_EDGE_CHROME" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_LAPS" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_LocalAdministrator" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_OfficeSettings" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_RemoteDesktop" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_Security" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-CLIENT_Firewall" | New-GPLink -Target "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"

Get-GPO -Name "CONTOSO-SERVER_AuditPolicy" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_Firewall" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_Security" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_ServerSettings" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_LocalAdministrator" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_LAPS" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_RemoteDesktop" | New-GPLink -Target "OU=Servers,DC=corp,DC=contoso,DC=com"

Get-GPO -Name "CONTOSO-SERVER_AuditPolicy" | New-GPLink -Target "OU=Domain Controllers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_Firewall" | New-GPLink -Target "OU=Domain Controllers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_Security" | New-GPLink -Target "OU=Domain Controllers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_ServerSettings" | New-GPLink -Target "OU=Domain Controllers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_LocalAdministrator" | New-GPLink -Target "OU=Domain Controllers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-SERVER_LAPS" | New-GPLink -Target "OU=Domain Controllers,DC=corp,DC=contoso,DC=com"

Get-GPO -Name "CONTOSO-USER_Desktop_StartMenu_Taskbar_Notifications" | New-GPLink -Target "OU=AllUsers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-USER_FolderRedirection" | New-GPLink -Target "OU=AllUsers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-USER_Preferences" | New-GPLink -Target "OU=AllUsers,DC=corp,DC=contoso,DC=com"
Get-GPO -Name "CONTOSO-USER_DriveMapping" | New-GPLink -Target "OU=AllUsers,DC=corp,DC=contoso,DC=com"
