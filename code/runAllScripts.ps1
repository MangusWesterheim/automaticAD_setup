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

Set-Location 'C:\Users\Administrator\Downloads\Scripts\'

$scriptsList =
@(
    .\ou.ps1                      # Oppretter OUer
    .\redirect_comp.ps1           # Omdirigerer/flytter maskiner fra container til OU
    .\AddUsers.ps1                # Oppretter brukere (kjører userCSVScripts.ps1)
    .\createGroups.ps1            # Oppretter grupper.
    .\shares.ps1                  # Oppretter og deler shares-mapper
    .\LAPS.ps1                    # Installerer LAPS
    .\importGPO.ps1               # Importerer GPOer
    .\delegateResetPassword.ps1   # Delegerer rettigheter for tilbakestilling av passord
    .\resticSetup.ps1             # Installerer restic og setter opp backup
    .\IIS.ps1                     # Installerer IIS og setter opp webside
)

$i = 0

# Sjekker at den finner alle skriptene:
foreach($script in $scriptsList)
{
    if ($script) {
        $i++
    } else {
        break
    }
}

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