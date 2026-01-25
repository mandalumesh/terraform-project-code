resource "azurerm_resource_group" "RG" {
  name     = "motu-rg1"
  location = "westus2"

}

resource "azurerm_storage_account" "storage" {
  name                     = "motuwstorage"
  location                 = "westus2"
  resource_group_name      = "motu-rg1"
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "azurerm_storage_container" "container" {
  name                = "storagecontainer"
  storage_account_name  = "motuwstorage"
  container_access_type = "private"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "motu-rg1"                 # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "motuwstorage"                     # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "storagecontainer"                    # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "prod.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}