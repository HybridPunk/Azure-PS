# Variables
## Global
$ResourceGroupName = "rg-2"
$Location = "NorthEurope"

## Compute
$VMName = "vm-test-002"

# Derived Variables
#Storage Accounts
$Disk1Name = "disk"+$VMName + "-lun1"
$InterfaceName = "nic-" + $VMName + "-01"

##Error does not work!

$diskConfig = New-AzureRmDiskConfig -Location $Location -CreateOption Empty -DiskSizeGB 128 -
$dataDisk = New-AzureRmVhd -ResourceGroupName $ResourceGroupName -DiskName $Disk1Name -Disk $diskConfig
$vm = Get-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName
$vm = Add-AzureRmVMVhd -VM $vm -Name myDataDisk -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1
Update-AzureRmVM -ResourceGroupName myResourceGroup -VM $vm