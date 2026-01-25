resource "azurerm_resource_group" "rg" {
  name     = "revision-rg"
  location = "central india"
}

resource "azurerm_storage_account" "storageacc" {
  name                     = "revisionstg"
  resource_group_name      = "revision-rg"
  location                 = "central india"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev-teast"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "vhds"
  storage_account_id    = "/subscriptions/386bf8df-3557-497d-bc9b-e22e349d7257/resourceGroups/revision-rg/providers/Microsoft.Storage/storageAccounts/revisionstg"
  container_access_type = "private"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "revision-vnet"
  location            = "central india"
  resource_group_name = "revision-rg"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "revision-subnet"
  resource_group_name  = "revision-rg"
  virtual_network_name = "revision-vnet"
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "revision-nic"
  location            = "central india"
  resource_group_name = "revision-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/386bf8df-3557-497d-bc9b-e22e349d7257/resourceGroups/revision-rg/providers/Microsoft.Network/virtualNetworks/revision-vnet/subnets/revision-subnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/386bf8df-3557-497d-bc9b-e22e349d7257/resourceGroups/revision-rg/providers/Microsoft.Network/publicIPAddresses/rivision-PublicIp1"
  }
}
resource "azurerm_public_ip" "pip" {
  name                = "rivision-PublicIp1"
  resource_group_name = "revision-rg"
  location            = "central india"
  allocation_method   = "Static"

  tags = {
    environment = "Dev-test"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "revision-vm-machine"
  resource_group_name             = "revision-rg"
  location                        = "central india"
  size                            = "Standard_F2"
  admin_username                  = "azurvm"
  admin_password                  = "Azure@123"
  disable_password_authentication = false

  network_interface_ids = [
    "/subscriptions/386bf8df-3557-497d-bc9b-e22e349d7257/resourceGroups/revision-rg/providers/Microsoft.Network/networkInterfaces/revision-nic"
  ]

  #   admin_ssh_key {
  #     username   = "adminuser"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "revision-nsg"
  location            = "central india"
  resource_group_name = "revision-rg"
}

resource "azurerm_network_security_rule" "nsgulre" {
  name                        = "nsg-rule"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "revision-rg"
  network_security_group_name = "revision-nsg"
}