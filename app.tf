provider "azurerm" {
}
variable "access_key" {}
resource "azurerm_resource_group" "test" {
  name     = "test-app-todo"
  location = "East US"
}

resource "azurerm_app_service_plan" "test" {
  name                = "some-app-service-plan"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "todoApptestx"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.test.id}"
}

output "address" {
  value = "${azurerm_app_service.test.default_site_hostname}"
}

terraform {
  required_version = "0.11.7"
  backend "azurerm" {
    storage_account_name = "todoteststorage"
    container_name       = "test"
    key                  = "test.terraform.tfstate"
  }
}
