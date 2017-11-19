# Variables
## Global
$ResourceGroupName = "rg-2"
$Location = "NorthEurope"
## Storage
$StorageName = "storagevmstdgrs"
   
## Network
$VNetName = "vnet_192.168.0.0_16"
$Subnet1Name = "vlan_192.168.1.0_24"

## Compute
$VMName = "vm-test-002"
$ComputerName = $VMName
$VMSize = "Standard_A2"

# Derived Variables
#Storage Accounts
$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageName
$OSDiskName = "disk"+$VMName + "-lun0"
$InterfaceName = "nic-" + $VMName + "-01"

# Network 
$VNet = Get-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName
$SubnetConfig = Get-AzureRmVirtualNetworkSubnetConfig -Name $Subnet1Name -VirtualNetwork $VNet
$Interface = New-AzureRmNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $SubnetConfig.Id
#$PIp = New-AzureRmPublicIpAddress -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Dynamic
    
# Compute
## Setup local VM object
$Credential = Get-Credential
$VirtualMachine = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSize
$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $ComputerName -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Set-AzureRmVMSourceImage -VM $VirtualMachine -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2012-R2-Datacenter -Version "latest"
$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id
$OSDiskUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $OSDiskName + ".vhd"
$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption FromImage

## Create the VM in Azure
New-AzureRmVM   -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine 
# [[-DisableBginfoExtension]] `
# [-LicenseType <System.String>] `
# [-Tags <Hashtable>]   