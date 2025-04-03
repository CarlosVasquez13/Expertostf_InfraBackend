resource "azurerm_service_plan" "sp-backend" {
    name = "sp-backend-${var.project_name}-${var.environment}"
    location = var.location
    resource_group_name = "rg-${var.project_name}-${var.environment}" 
    sku_name = "B1"
    os_type = "Linux"
    tags = var.tags
}

resource "azurerm_linux_web_app" "webapp-api" {
    name = "api-${var.project_name}-${var.environment}"
    location = var.location
    resource_group_name = "rg-${var.project_name}-${var.environment}"
    service_plan_id = azurerm_service_plan.sp-backend.id

    site_config {
      always_on = true
      application_stack {
        docker_registry_url = "https://index.docker.io"
        docker_image_name = "nginx:latest"
      }
    }

    app_settings = {
      WEBSITES_PORT = "80"
    }
}

resource "azurerm_linux_web_app" "webapp-api-admin" {
    name = "api-admin-${var.project_name}-${var.environment}"
    location = var.location
    resource_group_name = "rg-${var.project_name}-${var.environment}"
    service_plan_id = azurerm_service_plan.sp-backend.id

    site_config {
      always_on = true
      application_stack {
        docker_registry_url = "https://index.docker.io"
        docker_image_name = "nginx:latest"
      }
    }

    app_settings = {
      WEBSITES_PORT = "80"
    }
}