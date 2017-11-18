#Variables
$VMName = "vm-test-002"
$ResourceGroupName = "rg_1"
$Location = "NorthEurope"
$VmSize = "Standard_D2_v3"

#if target vm is different cluste need to de-alloacte to allow resize.
Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName

$vm = Get-AzureRmVM -ResourceGroupName $ResourceGroupName -VMName $VMName
$vm.HardwareProfile.VmSize = $VmSize
Update-AzureRmVM -VM $vm -ResourceGroupName $ResourceGroupName

#if deallocated the the VM will need to be started
Start-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName
