# Create resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Create virtual network
resource "azurerm_virtual_network" "example" {
    name = var.virtual_network_name
    address_space = var.virtual_network_address_space
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

# Create subnet
resource "azurerm_subnet" "example" {
  name = var.virtual_subnet_name
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes = var.virtual_subnet_size

}

# Create public IPs
resource "azurerm_public_ip" "example" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = var.public_ip_allocation
}

# Create network interface
resource "azurerm_network_interface" "example" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}


# Get Client IP Address for NSG
data "http" "myip" {
  url = "https://ipv4.icanhazip.com/"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "example" {
  name = var.network_security_group_name
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

        security_rule {
        name                       = "Allow Connection"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "${chomp(data.http.myip.body)}/32"
        destination_address_prefix = "*"
    }
}

# Connect the Network Security Group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id = azurerm_network_interface.example.id
    network_security_group_id = azurerm_network_security_group.example.id
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "example" {
  name                = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}