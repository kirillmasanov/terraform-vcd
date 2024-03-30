variable "vcd_org_user" {
  default     = "administrator"
  description = "vCD Tenant User"
}

variable "vcd_org_password" {
  default     = "password"
  description = "vCD Tenant Password"
}

variable "vcd_org_org" {
  default     = "def_org"
  description = "vCD Tenant Org"
}

variable "vcd_org_url" {
  default     = "https://url/api"
  description = "vCD Tenant URL"
}

variable "vcd_org_vdc" {
  default     = "def_org_vdc"
  description = "vCD Tenant VDC"
}

variable "vcd_org_max_retry_timeout" {
  default     = 240
  description = "Retry Timeout"
}

variable "vcd_org_allow_unverified_ssl" {
  default     = "true"
  description = "vCD allow unverified SSL"
}

variable "vcd_org_edge_name" {
  default     = "def_edge"
  description = "vCD edge name"
}

variable "vcd_org_catalog" {
  default     = "org_catalog"
  description = "vCD Catalog Name"
}

variable "template_vm" {
  default     = "ubuntu-server-22.04"
  description = "template vm"
}
