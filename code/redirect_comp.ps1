# Omdirigerer computers containers
redircmp "OU=Clients,DC=corp,DC=contoso,DC=com"

# Hentet fra https://gitlab.com/erikhje/dcsg1005/-/blob/master/compendia.md
# Flytter CL1 og MGR fra container til Clients-OU:
Get-ADComputer "CL1" |
  Move-ADObject -TargetPath "OU=Clients,DC=corp,DC=contoso,DC=com"
Get-ADComputer "MGR" |
  Move-ADObject -TargetPath "OU=Clients,DC=corp,DC=contoso,DC=com"

# Flytter SRV1 fra container til Servers-OU:
Get-ADComputer "SRV1" |
  Move-ADObject -TargetPath "OU=Servers,DC=corp,DC=contoso,DC=com"

