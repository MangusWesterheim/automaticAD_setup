#Requires -RunAsAdministrator

# https://www.shellandco.net/delegate-the-reset-password-permission/

Import-Module ActiveDirectory

#Variables
$domain = "corp.contoso"
$forest = "com"
$dc = "dc1"
$grp = "dl_it_resetPassword"
$dn = "OU=AllUsers,DC=corp,DC=contoso,DC=com"
$domain_fqdn = $domain + "." + $forest
$dc_fqdn = $dc + "." + $domain_fqdn

New-PSDrive -Name AD -PSProvider ActiveDirectory -Server 'DC1.corp.contoso.com' -root "//RootDSE/"

#Get OU ACL
$acl = Get-ACL "AD:\$dn"

#Get Group SID
$s = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup -Server $dc_fqdn $grp).SID

#Add ACL rule for the right "Reset password"
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$s,"ExtendedRight","Allow",([GUID]("00299570-246d-11d0-a768-00aa006e0529")).guid,"Descendents",([GUID]("bf967aba-0de6-11d0-a285-00aa003049e2")).guid))

#Apply both ACL rules above
Set-ACL "AD:\$dn" $acl


