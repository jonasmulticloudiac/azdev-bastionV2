############################
## Bastion Network - Main ##
############################

# Create a Resource Group
resource "azurerm_resource_group" "bastion-rg" {
  name     = "${var.prefix}-${var.environment}-bastion-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Create the VNET
resource "azurerm_virtual_network" "bastion-vnet" {
  name                = "${var.prefix}-${var.environment}-bastion-vnet"
  address_space       = [var.bastion-vnet-cidr]
  resource_group_name = azurerm_resource_group.bastion-rg.name
  location            = azurerm_resource_group.bastion-rg.location
  tags = {
    environment = var.environment
  }
}

# Criando a subnet das vm-windows
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "${var.prefix}-${var.environment}-bastion-subnet"
  address_prefixes     = [var.bastion-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.bastion-vnet.name
  resource_group_name  = azurerm_resource_group.bastion-rg.name
}

# Criando a AzureBastionSubnet
resource "azurerm_subnet" "bastion_subnet_host" {
  name                      = "AzureBastionSubnet"
  resource_group_name       =  azurerm_resource_group.bastion-rg.name
  virtual_network_name      =  azurerm_virtual_network.bastion-vnet.name
  address_prefixes          = [var.bastion_subnet_prefix]
}

# Criando o  IP publico associado ao Azure Bastion
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "${var.prefix}-${var.environment}-bastion-host-ip"
  location            = azurerm_resource_group.bastion-rg.location
  resource_group_name = azurerm_resource_group.bastion-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Criando o Bastion Host
resource "azurerm_bastion_host" "bastion_host" {
  name                = "${var.prefix}-${var.environment}-bastion-host"
  location            = azurerm_resource_group.bastion-rg.location
  resource_group_name = azurerm_resource_group.bastion-rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet_host.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}