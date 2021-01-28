####################
# Common Variables #
####################
company     = "TheCloudBootcamp"
prefix      = "tcb"
environment = "dev"
location    = "eastus"
description = "Deploy a Bastion Server"
owner       = "Jonas Isaias"
app_name    = "Iac-Bastion"

##################
# Authentication #
##################
/* azure-subscription-id = "complete-this"
azure-client-id       = "complete-this"
azure-client-secret   = "complete-this"
azure-tenant-id       = "complete-this" */

###################
# Bastion Network #
###################
bastion-vnet-cidr   = "10.10.0.0/16"
bastion-subnet-cidr = "10.10.1.0/24"
bastion_subnet_prefix = "10.10.224.0/24"

##############
# Bastion VM #
##############
bastion-windows-vm-hostname    = "winbastion" // Limited to 15 characters
bastion-windows-vm-size        = "Standard_DS1_v2"
bastion-windows-admin-username = "rootadmin"
bastion-windows-admin-password = "123456@Tcb"
