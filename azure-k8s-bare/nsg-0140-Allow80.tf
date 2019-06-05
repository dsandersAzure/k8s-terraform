module "nsg-Allow80" {
  source                      = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg_rule?ref=0.1.0"
  name                        = "Allow80"
  resource-group-name         = "${module.resource-group.name}"
  network-security-group-name = "${module.nsg-k8s.name}"
  priority                    = "140"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source-address-prefix       = "Internet"
  source-port-range           = "*"
  destination-address-prefix  = "*"
  destination-port-range      = "80"
}

