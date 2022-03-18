
# Kode brukt (se rapport).

#
Import-Module activedirectory

# Leser og oppretter OUer fra csv-fil (header: name;path;description):
$ADOU = Import-csv C:\Users\Administrator\Documents\ou.csv -Delimiter ";"
foreach ($ou in $ADOU) {
    New-ADOrganizationalUnit `
    -Name $ou.name `
    -Path $ou.path `
    -Description $ou.description `
}


