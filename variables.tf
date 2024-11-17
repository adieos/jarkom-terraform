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
    // A1
    "nasi-uduk-D06" = "192.168.6.34/29"
    "geprek-D06" = "192.168.6.35/29"
    "alfamart-sw2" = "192.168.6.33/29"

    // A2
    "kwetiaw-D06" = "192.168.6.2/30"
    "alfamart-sw1" = "192.168.6.1/30"

    // A3
    "alfamart-eth0" = "192.168.6.6/30"
    "infomaret-eth1" = "192.168.6.5/30"

    // A4
    "indomaret-eth0" = "192.168.6.10/30"
    "family-mart-eth1" = "192.168.6.9/30"

    // A5
    
  }
}

variable "gateaway_list" {
  type        = map(string)
  default = {
    // A1
    "nasi-uduk-D06" = "192.168.6.33"
    "geprek-D06" = "192.168.6.33"

    // A2
    "kwetiaw-D06" = "192.168.0.1"

    // A3
    "alfamart-eth0" = "192.168.6.5"

    // A4
    "indomaret-eth0" = "192.168.6.9"
  }
}