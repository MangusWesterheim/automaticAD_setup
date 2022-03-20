Requires -RunAsAdministrator

###################################################################################
# Dette skriptet omdirigerer nye maskiner fra Computers-container til Clients-OU, #
# I tillegg flyttes over CL1 og MGR fra samme container til Clients-OU,           #
# og SRV1 til Servers-OU                                                          #
#                                                                                 #
###################################################################################

# Omdirigerer computers containers
redircmp "OU=Clients,DC=corp,DC=contoso,DC=com"

# Flytter CL1 og MGR fra container til Clients-OU (fra "Compendia"):
Get-ADComputer "CL1" |
  Move-ADObject -TargetPath "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"
Get-ADComputer "MGR" |
  Move-ADObject -TargetPath "OU=Employee,OU=Clients,DC=corp,DC=contoso,DC=com"

# Flytter SRV1 fra container til Servers-OU:
Get-ADComputer "SRV1" |
  Move-ADObject -TargetPath "OU=Servers,DC=corp,DC=contoso,DC=com"

