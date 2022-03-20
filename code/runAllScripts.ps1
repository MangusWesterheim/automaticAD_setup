######################################################################################
# Dette skriptet kjører alle skriptene som setter opp AD-strukturen.                 #
# Skriptene kjøres i riktig rekkefølge og stopper om et skript ikke blir funnet.     #
# Alle skriptene må ligge i en mappe "Scripts" med path som anvist i Set-Location.   #
#                                                                                    #
######################################################################################

$text = @"
   _____
  / ____|             | |
 | |      ___   _ __  | |_  ___   ___   ___
 | |     / _ \ | '_ \ | __|/ _ \ / __| / _ \
 | |____| (_) || | | || |_| (_) |\__ \| (_) |
  \_____|\___/ |_| |_| \__|\___/ |___/ \___/

"@

$text

#Set-Location 'C:\Users\Administrator\Downloads\Scripts\'


$1  = "ou.ps1"                      # Oppretter OUer
$2  = "redirect_comp.ps1"           # Omdirigerer/flytter maskiner fra container til OU
$3  = "AddUsers.ps1"                # Oppretter brukere (kjører userCSVScripts.ps1)
$4  = "createGroups.ps1"           # Oppretter grupper.
$5  = "shares.ps1"                  # Oppretter og deler shares-mapper
$6  = "LAPS.ps1"                    # Installerer LAPS
$7  = "importGPO.ps1"               # Importerer GPOer
$8  = "delegateResetPassword.ps1"   # Delegerer rettigheter for tilbakestilling av passord
$9  = "resticSetup.ps1"             # Installerer restic og setter opp backup
$10 = "IIS.ps1"                     # Installerer IIS og setter opp webside

if ((Test-Path -Path $1) -and (Test-Path -Path $2) -and (Test-Path -Path $3) -and `
    (Test-Path -Path $4) -and (Test-Path -Path $5) -and (Test-Path -Path $6) -and `
    (Test-Path -Path $7) -and (Test-Path -Path $8) -and (Test-Path -Path $9) -and `
    (Test-Path -Path $10)) {
Write-Output "******************************************************************************************"
Write-Output "*                                      Oppretter OUer                                    *"
Write-Output "******************************************************************************************"
.\ou.ps1

Write-Output "******************************************************************************************"
Write-Output "*                    Omdirigerer/flytter maskiner fra container til OU                   *"
Write-Output "******************************************************************************************"
.\redirect_comp.ps1

Write-Output "******************************************************************************************"
Write-Output "*                       Oppretter brukere (kjører userCSVScripts.ps1)                    *"
Write-Output "******************************************************************************************"
.\AddUsers.ps1

Write-Output "******************************************************************************************"
Write-Output "*                                   Oppretter grupper.                                   *"
Write-Output "******************************************************************************************"
.\createGroups.ps1

Write-Output "******************************************************************************************"
Write-Output "*                             Oppretter og deler shares-mapper                           *"
Write-Output "******************************************************************************************"
.\shares.ps1

Write-Output "******************************************************************************************"
Write-Output "*                                      Installerer LAPS                                  *"
Write-Output "******************************************************************************************"
.\LAPS.ps1

Write-Output "******************************************************************************************"
Write-Output "*                                      Importerer GPOer                                  *"
Write-Output "******************************************************************************************"
.\importGPO.ps1

Write-Output "******************************************************************************************"
Write-Output "*                  Delegerer rettigheter for tilbakestilling av passord                  *"
Write-Output "******************************************************************************************"
.\delegateResetPassword.ps1

Write-Output "******************************************************************************************"
Write-Output "*                         Installerer restic og setter opp backup                        *"
Write-Output "******************************************************************************************"
.\resticSetup.ps1

Write-Output "******************************************************************************************"
Write-Output "*                          Installerer IIS og setter opp webside                         *"
Write-Output "******************************************************************************************"
.\IIS.ps1
} else {
    Write-Output "Fant ikke skript."
}