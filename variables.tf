variable  "proxmox_url" {
    type = string
}
variable  "proxmox_user" {
    type = string
}
variable  "proxmox_password" {
    type = string
}

variable "vm_id_list" {
  type        = map(number)
  default = {
    "nasi-uduk-D06" = 270
  }
}

variable "ip_list" {
  type        = map(string)
  default = {
    "nasi-uduk-D06" = "192.168.6.34/29"
  }
}

variable "gateaway_list" {
  type        = map(string)
  default = {
    "nasi-uduk-D06" = "192.168.6.33"
  }
}