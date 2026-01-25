resource "azurerm_resource_group" "dynamic-rg" {
    for_each = var.dynamic-rg
  name     =each.value.name
  location = each.value.location

}
resource "azurerm_virtual_network" "dynamic-vnet" {
    for_each= var.VNet
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
    # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "fronted-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet {
    name             = "backend-subnet"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.0.3.0/24"]
  }
}
