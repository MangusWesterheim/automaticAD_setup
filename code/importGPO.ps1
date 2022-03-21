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
$URLs = @('https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/GoogleChromePolicyTemplates.zip', 'https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/MicrosoftEdgePolicyTemplates.zip', 'https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/MicrosoftOfficePolicyTemplates.zip')
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

$gpoPath = 'C:\Temp\GPO\GPO\GPOs'
$migtable = 'C:\Temp\GPO\GPO\migtable.migtable'
import-gpo -BackupGpoName CONTOSO-CLIENT_AppLocker -TargetName CONTOSO-CLIENT_AppLocker -path $gpoPath -MigrationTable $migtable -CreateIfNeeded

$gpoName1 = @("CONTOSO-CLIENT_AppLocker", "CONTOSO-CLIENT_AuditPolicy", "CONTOSO-CLIENT_ClientSettings", "CONTOSO-CLIENT_IE_EDGE_CHROME",
    "CONTOSO-CLIENT_LAPS", "CONTOSO-CLIENT_LocalAdministrator", "CONTOSO-CLIENT_OfficeSettings", "CONTOSO-CLIENT_RemoteDesktop",
    "CONTOSO-CLIENT_Security", "CONTOSO-CLIENT_Firewall")
$gpoName2 = @("CONTOSO-SERVER_AuditPolicy", "CONTOSO-SERVER_Firewall", "CONTOSO-SERVER_Security",
    "CONTOSO-SERVER_ServerSettings", "CONTOSO-SERVER_LocalAdministrator", "CONTOSO-SERVER_LAPS", "CONTOSO-SERVER_RemoteDesktop")
$gpoName3 = @( "CONTOSO-USER_Desktop_StartMenu_Taskbar_Notifications", "CONTOSO-USER_FolderRedirection", "CONTOSO-USER_Preferences", "CONTOSO-USER_DriveMapping")

$gpoNameAll = $gpoName1 + $gpoName2 + $gpoName3



##Importer sikkerhetskopierte GPOer og Migration Table
$gpoNameAll | ForEach-Object {
    import-gpo -BackupGpoName $_ -TargetName $_ -path $gpoPath -MigrationTable $migtable -CreateIfNeeded
}

#Link GPO til OU
$target = 'OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com'

$gpoName1 | ForEach-Object {
    Get-GPO -Name $_ | New-GPLink -Target $target
}

$target = 'OU=Servers,DC=corp,DC=contoso,DC=com'

$gpoName2 | ForEach-Object {
    Get-GPO -Name $_ | New-GPLink -Target $target
}

$target = 'OU=Domain Controllers,DC=corp,DC=contoso,DC=com'

$gpoName2 | ForEach-Object {
    Get-GPO -Name $_ | New-GPLink -Target $target
}

$target = 'OU=AllUsers,DC=corp,DC=contoso,DC=com'

$gpoName3 | ForEach-Object {
    Get-GPO -Name $_ | New-GPLink -Target $target
}