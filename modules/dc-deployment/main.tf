

/*
    Resource Group
*/

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}rg${var.suffix}"
  location = var.location
  tags = {
    "owner" = var.owner
  }
}

/*
    Networking
*/

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}vnet${var.suffix}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}subnet${var.suffix}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "publicip" {
  name                = "${var.prefix}publicip${var.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}nic${var.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.prefix}nicConfig${var.suffix}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

/*
    Security Group 
*/

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}nsg${var.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "web"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

/* NOT REQUIRED IF CLOUD-INIT IS USED */
  security_rule {
    name                       = "ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
/**/

}


/*
    Virtual Machine
*/

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}vm${var.suffix}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"


  storage_os_disk {
    name              = "${var.prefix}OsDisk${var.suffix}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.prefix}vm${var.suffix}"
    admin_username = var.admin_username
    admin_password = var.admin_password
    custom_data    = data.template_file.custom_data.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }


/*
Provisioner not required, better use custom_data (cloud-init) instead, does the same without any SSH requirement

  provisioner "file" {
    source      = "${path.module}/vm-custom-data.sh"
    destination = "/tmp/custom-data.sh"

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.publicip.ip_address
    }

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/custom-data.sh",
      "/tmp/custom-data.sh"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.publicip.ip_address
    }

  }
*/
}


data "template_file" "custom_data" {
  template = file("${path.module}/cloud-init.yml")
}