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
    "geprek-D06" = 271
    "alfamart-D06" = 272
    "kwetiaw-D06" = 273
    "indomaret-D06" = 274
    "family-mart-D06" = 275
    "superindo-D06" = 276
    "sakinah-D06" = 277
    "pangsit-D06" = 278
    "naspad-D06" = 279
    "ikan-fillet-D06" = 280
    "its-mart-D06" = 281
    "tahu-tek-D06" = 282
    "sego-jamur-D06" = 283
  }
}

variable "ip_list" {
  type        = map(string)
  default = {
    // A1
    "nasi-uduk-D06" = "192.168.6.34/29"
    "geprek-D06" = "192.168.6.35/29"
    "alfamart-sw2" = "192.168.6.33/29" // gw

    // A2
    "kwetiaw-D06" = "192.168.6.2/30"
    "alfamart-sw1" = "192.168.6.1/30" // gw

    // A3
    "alfamart-eth0" = "192.168.6.6/30"
    "infomaret-eth1" = "192.168.6.5/30" // gw

    // A4
    "indomaret-eth0" = "192.168.6.10/30"
    "family-mart-eth1" = "192.168.6.9/30" // gw

    // A5
    "family-mart-eth2" = "192.168.6.13/30" // gw
    "superindo-eth0" = "192.168.6.14/30"

    // A6
    "superindo-sw4" = "192.168.6.41/29" // gw
    "its-mart-sw4" = "192.168.6.42/29"
    "ikan-fillet-D06" = "192.168.6.43/29"

    // A7
    "superindo-sakinah" = "192.168.6.17/30" // gw
    "sakinah-superindo" = "192.168.6.18/30"

    // A8
    "its-mart-sw5" = "192.168.6.49/29" // gw
    "tahu-tek-D06" = "192.168.6.50/29"
    "sego-jamur-D06" = "192.168.6.51/29"

    // A9
    "sakinah-sw3" = "192.168.6.57/29" // gw
    "pangsit-D06" = "192.168.6.58/29"
    "naspad-D06" = "192.168.6.59/29"
  }
}

variable "gateaway_list" {
  type        = map(string)
  default = {
    // A1
    "nasi-uduk-D06" = "192.168.6.33"
    "geprek-D06" = "192.168.6.33"

    // A2
    "kwetiaw-D06" = "192.168.6.1"

    // A3
    "alfamart-eth0" = "192.168.6.5"

    // A4
    "indomaret-eth0" = "192.168.6.9"

    // A5
    "superindo-eth0" = "192.168.6.13"

    // A6
    "ikan-fillet-D06" = "192.168.6.41"
    "its-mart-sw4" = "192.168.6.41"

    // A7
    "sakinah-superindo" = "192.168.6.17"

    // A8
    "tahu-tek-D06" = "192.168.6.49"
    "sego-jamur-D06" = "192.168.6.49"

    // A9
    "pangsit-D06" = "192.168.6.57"
    "naspad-D06" = "192.168.6.57"
  }
}