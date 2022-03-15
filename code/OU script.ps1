# User OUs
#  Fix: Description and path.
#  Add: More OUs?
New-ADOrganizationalUnit 'AllUsers' -Description 'Containing OUs and users'
New-ADOrganizationalUnit 'IT' -Description 'IT staff' `
  -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Adm' -Description 'Administration' `
  -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Employee' -Description 'Regular employees' `
  -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Management' -Description 'Management' `
  -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Inactive' -Description 'Inactive users' `
  -Path 'OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Finance' -Description 'Financial dep.'`
  -Path 'OU=Adm,OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Logistic' -Description 'Logistics dep.'`
  -Path 'OU=Adm,OU=AllUsers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Marketing' -Description ‘Marketing dep.'`
  -Path 'OU=Adm,OU=AllUsers,DC=sec,DC=core'




# Computer OUs
#  Fix: Description and path. 
#  Check: Apostrophe after lines.
#  Add: More OUs?
New-ADOrganizationalUnit 'Computers' -Description 'Containing OUs and users laptops' `
New-ADOrganizationalUnit 'Clients' -Description 'Containing OUs and users laptops' `
  -Path 'OU=Computers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Servers' -Description 'Containing OUs and servers' `
  -Path 'OU=Computers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Employee' -Description 'Employee laptops' `
  -Path 'OU=Clients,OU=Computers,DC=sec,DC=core'
New-ADOrganizationalUnit 'Kiosk' -Description 'Front desk and cash register' `
  -Path 'OU=Clients,OU=Computers,DC=sec,DC=core'



# Group OUs
#  Fix: Description and path.
#  Add: More OUs?
New-ADOrganizationalUnit 'Groups' -Description 'Containing OUs' `
New-ADOrganizationalUnit 'IT' -Description '...' `
  -Path 'OU=Groups,DC=sec,DC=core'
New-ADOrganizationalUnit 'Finance' -Description 'Financials…' `
  -Path 'OU=Groups,DC=sec,DC=core'
New-ADOrganizationalUnit 'Users' -Description 'Active users' `
  -Path 'OU=Groups,DC=sec,DC=core'
New-ADOrganizationalUnit 'Mail' -Description 'Mail distribution lists' `
  -Path 'OU=Groups,DC=sec,DC=core'
New-ADOrganizationalUnit 'Security' -Description 'Containing OUs...' `
  -Path 'OU=Groups,DC=sec,DC=core'
New-ADOrganizationalUnit 'Telephone' -Description 'Telephone system' `
  -Path 'OU=Groups,DC=sec,DC=core'
