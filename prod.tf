module "vm_prod" {
    source = "./Modules"
    resource_group_name = "prod-rg"
    resource_group_location = "Australia East"
    virtual_network_name = "prod-network"
    virtual_network_address_space = ["10.0.0.0/16"]
    virtual_subnet_name = "prod-subnet1"
    virtual_subnet_size = ["10.0.2.0/24"]
    public_ip_name = "prod-pip"
    public_ip_allocation = "Dynamic"
    network_interface_name = "prod-nic"
    network_security_group_name = "prod-nsg"
    virtual_machine_name = "prod-vm"
}