# User OUs
#  Add: More OUs?
New-ADOrganizationalUnit 'AllUsers' -Description 'Containing OUs and users'
New-ADOrganizationalUnit 'IT' -Description 'IT staff' `
  -Path 'OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Adm' -Description 'Administration' `
  -Path 'OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Employee' -Description 'Regular employees' `
  -Path 'OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Management' -Description 'Management' `
  -Path 'OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Inactive' -Description 'Inactive users' `
  -Path 'OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Finance' -Description 'Financial dep.'`
  -Path 'OU=Adm,OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Logistic' -Description 'Logistics dep.'`
  -Path 'OU=Adm,OU=AllUsers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Marketing' -Description 'Marketing dep.'`
  -Path 'OU=Adm,OU=AllUsers,DC=corp,DC=contoso,DC=com'




# Computer OUs
#  Add: More OUs?
New-ADOrganizationalUnit 'Computers' -Description 'Containing OUs' `
New-ADOrganizationalUnit 'Clients' -Description 'Containing OUs, user laptops, workstations' `
  -Path 'OU=Computers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Servers' -Description 'SRV1' `
  -Path 'OU=Computers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Employee' -Description 'Employee laptops' `
  -Path 'OU=Clients,OU=Computers,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Kiosk' -Description 'Front desk and cash register' `
  -Path 'OU=Clients,OU=Computers,DC=corp,DC=contoso,DC=com'



# Group OUs
#  Fix: More OUs/less OUs depending on groups + descriptions
New-ADOrganizationalUnit 'Groups' -Description 'Containing OUs' `
New-ADOrganizationalUnit 'IT' -Description '...' `
  -Path 'OU=Groups,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Finance' -Description 'Financials' `
  -Path 'OU=Groups,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Users' -Description 'Active users' `
  -Path 'OU=Groups,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Mail' -Description 'Mail distribution lists' `
  -Path 'OU=Groups,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Security' -Description 'Containing OUs...' `
  -Path 'OU=Groups,DC=corp,DC=contoso,DC=com'
New-ADOrganizationalUnit 'Telephone' -Description 'Telephone system' `
  -Path 'OU=Security,OU=Groups,DC=corp,DC=contoso,DC=com'
