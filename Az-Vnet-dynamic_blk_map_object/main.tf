resource "azurerm_resource_group" "dynamic-rg" {
  for_each = var.dynamic-rg
  name     = each.value.name
  location = each.value.location

}
resource "azurerm_virtual_network" "dynamic_vnet" {
  for_each            = var.VNet
  depends_on          = [var.dynamic-rg]
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }
}
