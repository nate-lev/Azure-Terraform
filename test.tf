module "vm_test" {
    source = "./Modules"
    resource_group_name = "test-rg"
    resource_group_location = "Australia East"
    virtual_network_name = "test-network"
    virtual_network_address_space = ["10.0.0.0/16"]
    virtual_subnet_name = "test-subnet1"
    virtual_subnet_size = ["10.0.2.0/24"]
    public_ip_name = "test-pip"
    public_ip_allocation = "Dynamic"
    network_interface_name = "test-nic"
    network_security_group_name = "test-nsg"
    virtual_machine_name = "test-vm"
}