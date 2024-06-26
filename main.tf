terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.10.0"
    }
  }
  required_version = ">= 0.13"
}

provider "vcd" {
  auth_type            = "integrated"
  max_retry_timeout    = var.vcd_org_max_retry_timeout
  user                 = var.vcd_org_user
  password             = var.vcd_org_password
  org                  = var.vcd_org_org
  vdc                  = var.vcd_org_vdc
  url                  = var.vcd_org_url
  allow_unverified_ssl = var.vcd_org_allow_unverified_ssl
}

data "vcd_org_vdc" "vdc1" {
  name = var.vcd_org_vdc
}

data "vcd_nsxt_edgegateway" "existing" {
  org      = var.vcd_org_org
  name     = var.vcd_org_edge_name
  owner_id = data.vcd_org_vdc.vdc1.id
}

resource "vcd_network_routed_v2" "terraform-net" {
  name            = "terraform-net"
  edge_gateway_id = data.vcd_nsxt_edgegateway.existing.id
  gateway         = "192.168.200.1"
  prefix_length   = 24
  static_ip_pool {
    start_address = "192.168.200.101"
    end_address   = "192.168.200.254"
  }
}

### Data sources of catalog ###

data "vcd_catalog" "catalog" {
  org  = var.vcd_org_org
  name = "test-vapp"
}

data "vcd_catalog_vapp_template" "vapp" {
  org        = var.vcd_org_org
  catalog_id = data.vcd_catalog.catalog.id
  name       = "ubuntu-server-22.04"
}

### Create vApp ###

resource "vcd_vapp" "test" {
  name = "test"
}

### Create vApp subnet ###

resource "vcd_vapp_network" "vapp-net" {
  name          = "test_net"
  vapp_name     = vcd_vapp.test.name
  gateway       = "192.168.201.1"
  prefix_length = "24"

  static_ip_pool {
    start_address = "192.168.201.2"
    end_address   = "192.168.201.100"
  }
}

### Create vm from template ###

resource "vcd_vapp_vm" "test" {
  vapp_name = vcd_vapp.test.name
  name      = "test_vm"

  vapp_template_id = data.vcd_catalog_vapp_template.vapp.id
  cpus             = 1
  memory           = 1024

  network {
    name               = vcd_vapp_network.vapp-net.name
    type               = "vapp"
    ip_allocation_mode = "MANUAL"
    ip                 = "192.168.201.2"
  }
}
