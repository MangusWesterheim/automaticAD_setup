######################################################################################
# Dette skriptet invoker skriptet som oppretter csv filen for brukere og henter ut   #
#  innholdet og legger til brukere i ad basert på csv-filen                          #
#                                                                                    #
######################################################################################



# lager brukerne basert på csv filen
# Ignorerer feilmelding fra psscriptanalyzer

New-Item -Path C:\Temp -ItemType Directory -Force
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/PowerShell-7.2.2-win-x64.msi -OutFile "C:\temp\pwsh.msi"
Start-Process "msiexec" -ArgumentList "/i C:\Temp\pwsh.msi /quiet /norestart" -Wait -NoNewWindow -PassThru
Invoke-WebRequest -Uri https://raw.githubusercontent.com/dh-ctrl/DCSG1005_Infra_ActiveDirectory/main/UserCSVScript.ps1 -OutFile "UserCSVScript.ps1"
Start-Process "pwsh.exe" -ArgumentList "--file UserCSVScript.ps1"

while (!(Test-Path "contosousers.csv")) { Start-Sleep -Seconds 1 }

$ADUsers = Import-Csv contosousers.csv -Delimiter ";"

# Ignorerer psscriptanalyzer regler slik at skriptet går gjennom pipeline
function Get-SecurePassword {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "", Scope = "Function")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "", Scope = "Function")]
    param ([string] $password)
    $secureString = ConvertTo-SecureString $password -AsPlainText -Force
    return $secureString
}

# Legger til brukere
foreach ($User in $ADUsers) {
    New-ADUser `
        -SamAccountName        $User.Username `
        -UserPrincipalName     $User.UserPrincipalName `
        -Name                  $User.DisplayName `
        -GivenName             $User.GivenName `
        -Surname               $User.SurName `
        -Enabled               $True `
        -ChangePasswordAtLogon $False `
        -DisplayName           $user.Displayname `
        -Department            $user.Department `
        -Title	               $user.Title `
        -Description           $user.Description `
        -Path                  $user.path `
        -AccountPassword (Get-SecurePassword -Password $user.Password)
}