# Variables
## Global
$ResourceGroupName = "rg-2"
$Location = "NorthEurope"
$AvailabiltySetName = "as-test"
$FaultDomain = "2"
$UpdateDomain = "2"

New-AzureRmAvailabilitySet `
-Location $Location `
-Name $AvailabiltySetName `
-ResourceGroupName $ResourceGroupName `
-PlatformFaultDomainCount $FaultDomain  `
-PlatformUpdateDomainCount $UpdateDomain
 #help
 