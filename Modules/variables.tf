variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "resource_group_location" {
    type = string
    description = "Location of resource group"
}

variable "virtual_network_name" {
    type = string
    description = "Name of the Virtual Network"
}

variable "virtual_network_address_space" {
    type = list(string)
    description = "Size of the virtual network address space"
}

variable "virtual_subnet_name" {
    type = string
    description = "Name of the virutal network subnet"
}

variable "virtual_subnet_size" {
    type = list(string)
    description = "Size of the virtual network subnet"
}

variable "public_ip_name" {
    type = string
    description = "Name of the Public IP"
}

variable "public_ip_allocation" {
    type = string
    description = "Dynamic or static public IP allocation"
}

variable "network_interface_name" {
    type = string
    description = "Name of the network interface"
}

variable "network_security_group_name" {
    type = string
    description = "Name of the Network Security Group"
}

variable "virtual_machine_name" {
    type = string
    description = "Name of the Virtual Machine"
}