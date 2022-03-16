# Kode brukt: https://gitlab.com/erikhje/heat-mono/-/raw/master/scripts/CreateUserCSV.ps1
#
#
# Skript som oppretter en csv fil med alle brukerene vi skal ha i ad
# # Overskrifter: Username;GivenName;SurName;UserPrincipalName;DisplayName;Password;Department;Path
# foreach ($User in $ADUsers) {
#     New-ADUser `
#     -SamAccountName        $User.Username `
#     -UserPrincipalName     $User.UserPrincipalName `
#     -Name                  $User.DisplayName `
#     -GivenName             $User.GivenName `
#     -Surname               $User.SurName `
#     -Enabled               $True `
#     -ChangePasswordAtLogon $False `
#     -DisplayName           $user.Displayname `
#     -Department            $user.Department `
#     -Title 		     $user.Title 
#     -Path                  $user.path `
#     -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force)
# }
# Test sånn at vi ikke ender opp med to like csv filer
#
if ((Get-ChildItem -ErrorAction SilentlyContinue contesousers.csv).Exists)
  {"You already have the file contesousers.csv!"; return;}

# 
# 100 etternavn
$FirstName = @("Nora","Emma","Ella","Maja","Olivia","Emilie","Sofie","Leah",
               "Sofia","Ingrid","Frida","Sara","Tiril","Selma","Ada","Hedda",
               "Amalie","Anna","Alma","Eva","Mia","Thea","Live","Ida","Astrid",
               "Ellinor","Vilde","Linnea","Iben","Aurora","Mathilde","Jenny",
               "Tuva","Julie","Oda","Sigrid","Amanda","Lilly","Hedvig",
               "Victoria","Amelia","Josefine","Agnes","Solveig","Saga","Marie",
               "Eline","Oline","Maria","Hege","Jakob","Emil","Noah","Oliver",
               "Filip","William","Lucas","Liam","Henrik","Oskar","Aksel",
               "Theodor","Elias","Kasper","Magnus","Johannes","Isak","Mathias",
               "Tobias","Olav","Sander","Haakon","Jonas","Ludvig","Benjamin",
               "Matheo","Alfred","Alexander","Victor","Markus","Theo",
               "Mohammad","Herman","Adam","Ulrik","Iver","Sebastian","Johan",
               "Odin","Leon","Nikolai","Even","Leo","Kristian","Mikkel",
               "Gustav","Felix","Sverre","Adrian","Lars"
              )

# 
# 100 etternavn
$LastName = @("Hansen","Johansen","Olsen","Larsen","Andersen","Pedersen",
              "Nilsen","Kristiansen","Jensen","Karlsen","Johnsen","Pettersen",
              "Eriksen","Berg","Haugen","Hagen","Johannessen","Andreassen",
              "Jacobsen","Dahl","Jørgensen","Henriksen","Lund","Halvorsen",
              "Sørensen","Jakobsen","Moen","Gundersen","Iversen","Strand",
              "Solberg","Svendsen","Eide","Knutsen","Martinsen","Paulsen",
              "Bakken","Kristoffersen","Mathisen","Lie","Amundsen","Nguyen",
              "Rasmussen","Ali","Lunde","Solheim","Berge","Moe","Nygård",
              "Bakke","Kristensen","Fredriksen","Holm","Lien","Hauge",
              "Christensen","Andresen","Nielsen","Knudsen","Evensen","Sæther",
              "Aas","Myhre","Hanssen","Ahmed","Haugland","Thomassen",
              "Sivertsen","Simonsen","Danielsen","Berntsen","Sandvik",
              "Rønning","Arnesen","Antonsen","Næss","Vik","Haug","Ellingsen",
              "Thorsen","Edvardsen","Birkeland","Isaksen","Gulbrandsen","Ruud",
              "Aasen","Strøm","Myklebust","Tangen","Ødegård","Eliassen",
              "Helland","Bøe","Jenssen","Aune","Mikkelsen","Tveit","Brekke",
              "Abrahamsen","Madsen"
             )

# 5 i Management, 5 i Finance, 5 i logistic, 5 i Marketing og 82 i Employee(It ou tildeles direkte til brukere)
$OrgUnits = @("ou=Management,ou=Admin,ou=AllUsers","ou=Management,ou=Admin,ou=AllUsers",
	"ou=Management,ou=Admin,ou=AllUsers","ou=Management,ou=Admin,ou=AllUsers",
	"ou=Management,ou=Admin,ou=AllUsers","ou=Finance,ou=Admin,ou=AllUsers",
	"ou=Finance,ou=Admin,ou=AllUsers","ou=Finance,ou=Admin,ou=AllUsers",
	"ou=Finance,ou=Admin,ou=AllUsers","ou=Finance,ou=Admin,ou=AllUsers",
	"ou=Logistic,ou=Admin,ou=AllUsers","ou=Logistic,ou=Admin,ou=AllUsers",
	"ou=Logistic,ou=Admin,ou=AllUsers","ou=Logistic,ou=Admin,ou=AllUsers",
	"ou=Logistic,ou=Admin,ou=AllUsers","ou=Marketing,ou=Admin,ou=AllUsers",
	"ou=Marketing,ou=Admin,ou=AllUsers","ou=Marketing,ou=Admin,ou=AllUsers",
	"ou=Marketing,ou=Admin,ou=AllUsers","ou=Marketing,ou=Admin,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers"
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers""ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",	
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers","ou=Employee,ou=AllUsers",
	"ou=Employee,ou=AllUsers"
)

Write-Output "UserName;GivenName;SurName;UserPrincipalName;DisplayName;Password;Department;Stilling;Path" > contesousers.csv


# Hardkoder 3 brukere inn i it department sånn at det er lettere å opprette stillinger til de

$UserName          = "lars"
$GivenName         = "Lars"
$SurName           = "Pedersen"
$UserPrincipalName = $UserName + '@' + 'corp.conteso.com'
$DisplayName       = $GivenName + ' ' + $SurName
$Password          = -join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 16)
$Department        = "IT"
$Title		   = "Administrator" 	
$Path              = "ou=IT,ou=AllUsers" + ',' + "dc=CORP,dc=CONTESO,dc=COM"
Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Title;$Path" >> contesousers.csv

$UserName          = "gina"
$GivenName         = "Gina"
$SurName           = "Minervini"
$UserPrincipalName = $UserName + '@' + 'corp.conteso.com'
$DisplayName       = $GivenName + ' ' + $SurName
$Password          = -join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 16)
$Department        = "IT"
$Title		   = "Administrator" 	
$Path              = "ou=IT,ou=AllUsers" + ',' + "dc=CORP,dc=CONTESO,dc=COM"
Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Title;$Path" >> contesousers.csv

$UserName          = "peter"
$GivenName         = "Peter"
$SurName           = "Gran"
$UserPrincipalName = $UserName + '@' + 'corp.conteso.com'
$DisplayName       = $GivenName + ' ' + $SurName
$Password          = -join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 16)
$Department        = 'IT'
$Title		   = 'Apprentice' 	
$Path              = "ou=IT,ou=AllUsers" + ',' + "dc=CORP,dc=CONTESO,dc=COM"
Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department;$Title;$Path" >> contesousers.csv

# Mixer sammen fornavn, etternavn og path sånn at vi får tilfeldige brukere hver gang
#
$fnidx = 0..96 | Get-Random -Shuffle
$lnidx = 0..96 | Get-Random -Shuffle
$ouidx = 0..96 | Get-Random -Shuffle

# Oppretter resten av de 97 brukerene
foreach ($i in 0..96) {
  $UserName          = $FirstName[$fnidx[$i]].ToLower()
  $GivenName         = $FirstName[$fnidx[$i]]
  $SurName           = $LastName[$lnidx[$i]]
  $UserPrincipalName = $UserName + '@' + 'corp.conteso.com'
  $DisplayName       = $GivenName + ' ' + $SurName
  $Password          = -join ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789!"#$%&()*+,-./:<=>?@[\]_{|}'.ToCharArray() | Get-Random -Count 16)
  $Department        = ($OrgUnits[$ouidx[$i]] -split '[=,]')[1]
  $Path              = $OrgUnits[$ouidx[$i]] + ',' + "dc=CORP,dc=CONTESO,dc=COM"
  Write-Output "$UserName;$GivenName;$SurName;$UserPrincipalName;$DisplayName;$Password;$Department; ;$Path" >> contesousers.csv
}