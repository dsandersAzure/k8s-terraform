locals {
  l-pip-elb-temp-name = "${format("%s-%s%s", var.target, module.mgt-subnet.name, local.l-dev)}"
  l-pip-elb-name      = "${format("PIP-%s-%s%s", local.l-pip-elb-temp-name, var.environ, local.l-random)}"
  l-pip-elb-dns       = "${format("%s-%s%s", lower(local.l-pip-elb-temp-name), lower(var.environ), local.l-random)}"
}

module "pip-elb" {
  source                       = "git::https://github.com/dsandersAzure/terraform-library.git//modules/publicip?ref=0.5.2"
  name                         = "${local.l-pip-elb-name}"
  resource-group-name          = "${module.resource-group.name}"
  public-ip-address-allocation = "static"
  domain-name-label            = "${local.l-pip-elb-dns}"
  sku                          = "Basic"
  location                     = "${var.location}"
  tags                         = "${var.tags}"
}