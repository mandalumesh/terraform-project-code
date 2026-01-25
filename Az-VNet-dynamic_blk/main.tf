# resource "azurerm_resource_group" "dynamic-rg" {
#   name     = "dynamic-resources"
#   location = "West Europe"
# }
# resource "azurerm_virtual_network" "dynamic-vnet" {
#   name                = "dynamic-VNet"
#   location            = "West Europe"
#   resource_group_name = "dynamic-resources"
#   address_space       = ["10.0.0.0/16"]
#     # dns_servers         = ["10.0.0.4", "10.0.0.5"]

#   subnet {
#     name             = "fronted-subnet"
#     address_prefixes = ["10.0.1.0/24"]
#   }
#   subnet {
#     name             = "backend-subnet"
#     address_prefixes = ["10.0.2.0/24"]
#   }
#   subnet {
#     name             = "AzureBastionSubnet"
#     address_prefixes = ["10.0.3.0/24"]
#   }
# }
