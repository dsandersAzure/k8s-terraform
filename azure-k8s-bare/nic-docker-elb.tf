locals {
  l-nic-elb-temp-name  = "${format("%s-%s%s", var.target, "ELB", local.l-dev)}"
  l-nic-elb-name       = "${format("NIC-ELB-%s-%s%s", local.l-nic-elb-temp-name, var.environ, local.l-random)}"
  l-nic-elb-ip         = "${replace(var.elb-static-ip, "dc-prefix", var.dc-prefix)}"
}

module "nic-elb" {
  source              = "git::https://github.com/dsandersAzure/terraform-library.git//modules/public-nic"
  name                = "${local.l-nic-elb-name}"
  resource-group-name = "${module.resource-group.name}"
  allocation          = "Dynamic"
  subnet-id           = "${module.mgt-subnet.id}"
  public-ip-id        = "${module.pip-elb.id}"
  private-ip-address  = "${local.l-nic-elb-ip}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}
