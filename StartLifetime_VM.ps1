#Connect to Azure
################################################
$connectionName = "AzureRunAsConnection"

$servicePrincipalConnection = Get-AutomationConnection -Name $connectionName

Connect-AzAccount -TenantId $servicePrincipalConnection.TenantID `
    -ApplicationID $servicePrincipalConnection.ApplicationID `
    -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint
################################################

#Define VM Tags
################################################
$vmStatus = "VM deallocated"
$tagValue1 = "Shd"
$tagValue2 = "Arya Bera"
$vmName = "vm-ppl-shd-uks-out-01"
################################################

#Select the VMs with the Tags defined previously
################################################
$mySelectedVMs = Get-AzVM -status | Where-Object {$_.PowerState -eq $vmStatus `
    -and ($_.Name -eq $vmName)}
################################################

#Loop all the VMs that were found and turn them on
################################################
for ($i = 0; $i -lt $mySelectedVMs.Length; $i++) {
    $resourceGroupName = $mySelectedVMs[$i].ResourceGroupName
    $vmName = $mySelectedVMs[$i].Name

    Start-AzVM -ResourceGroupName $resourceGroupName -Name $vmName
}
################################################
