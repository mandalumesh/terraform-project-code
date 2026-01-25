# Concept 1

# resource "azurerm_resource_group" "dynamic-rg" {
#   for_each = var.dynamic-rg
#   name     = each.value.name
#   location = each.value.location
#   tags     = each.value.tags
# }

# Concept 2

resource "azurerm_resource_group" "dynamic-rg" {
  for_each   = var.dynamic-rg
  name       = each.value.name
  location   = each.value.location
  tags       = each.value.tags
  managed_by = each.value.managed_by
}
