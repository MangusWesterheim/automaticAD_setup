######################################################################################
# Dette skriptet kjører alle skriptene som setter opp AD-strukturen.                 #
# Skriptene kjøres i riktig rekkefølge og stopper om et skript ikke blir funnet.     #
#                                                                                    #
######################################################################################

Set-Location 'C:\Users\Administrator\Downloads\Scripts\'

$scriptsList =
@(
    .\ou.ps1                      # Oppretter OUer
    .\redirect_comp.ps1           # Omdirigere/flytte maskiner fra container til OU
    .\AddUsers.ps1                # Oppretter brukere (kjører userCSVScripts.ps1)
    .\shares.ps1                  # Oppretter og deler shares-mapper
    .\LAPS.ps1                    # Installerer LAPS
    .\importGPO.ps1               # Importerer GPOer
    .\delegateResetPassword.ps1   # Delegerer rettigheter for tilbakestilling av passord
    .\resticSetup.ps1             # Installerer restic og setter opp backup
    .\IIS.ps1                     # Installerer IIS og setter opp webside
)

$i = 0

# Kjører ett og ett skript, hvis det finnes:
foreach($script in $scriptsList)
{
    if ($script) {
        $script
        $i++
        Write-Output "Kjører $script."
    } else {
        Write-Output "Fant ikke $script"
        break
    }
}

# Alle skriptene har blitt kjørt:
if ($i -eq 9) {
    Write-Output "Konto klar."
}