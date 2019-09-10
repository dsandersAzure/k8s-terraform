# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nsg-subnet-assoc-worker.tf
# Environments:   all
# Purpose:        Module to associate the Azure network security group
#                 with the worker subnet.
#
# Created on:     08 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 08 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "azurerm_subnet_network_security_group_association" "k8s-nsg-snet-assoc-worker" {
  subnet_id                 = "${azurerm_subnet.k8s-subnet-worker.id}"
  network_security_group_id = "${azurerm_network_security_group.k8s-vnet-nsg.id}"
}