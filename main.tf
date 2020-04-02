provider "azurerm" {
  version = "~> 2.0"
  features {}
  subscription_id = var.subscription_id
  client_id = var.client_id
  tenant_id = var.tenant_id
}

# resource "azurerm_resource_group" "main" {
#   name     = "sbrd1zb1rsgdvpbr0gene001"
#   location = "Brazil South"
# }

# resource "azurerm_virtual_network" "main" {
#   name                = 
#   address_space       = ["10.0.0.0/16"]
#   location            = "Brazil South"
#   resource_group_name = "sbrd1zb1rsgdvpbr0gene001"
# }

# resource "azurerm_subnet" "internal" {
#   name                 = "default"
#   resource_group_name  = "sbrd1zb1rsgdvpbr0gene001"
#   virtual_network_name = "sbrd1zb1rsgdvpbr0gene001-vnet"
#   address_prefix       = "10.0.2.0/24"
# }

resource "azurerm_network_interface" "main" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resourcegroup

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resourcegroup}/providers/Microsoft.Network/virtualNetworks/${var.vnet}/subnets/${var.subnet}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.name}-vm"
  location              = var.location
  resource_group_name   = var.resourcegroup
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vmsize

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.name}-disk0"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  os_profile {
    computer_name  = "${var.name}name"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}