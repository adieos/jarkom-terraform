terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_url
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

// node DONE
resource "proxmox_virtual_environment_vm" "nasi-uduk-D06" {
    name = "nasi-uduk-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "nasi-uduk-D06")

    clone {
      datastore_id = "local-lvm"
      node_name = "its"
      vm_id = 5555
    }
    
    agent {
      enabled = false
    }

    initialization {
      ip_config { #eth0
        ipv4 {
          address = lookup(var.ip_list, "nasi-uduk-D06")
          gateway = lookup(var.gateaway_list, "nasi-uduk-D06")
        }
      }
      user_account {
        username = "D06"
        password = "hmd"
      }
    }

    cpu {
      cores = 1
      type = "x86-64-v2-AES"
    }

    memory {
      dedicated = 1024 # 1GB
      floating = 1024
    }

    disk {
      datastore_id = "local-lvm"
      file_id = "local:iso/focal-server-cloudimg-amd64.img"
      file_format = "raw"
      interface = "virtio0"
      iothread = true
      size = 3 # GB
    }

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}

// node WIP
resource "proxmox_virtual_environment_vm" "nasi-uduk-D06" {
    name = "nasi-uduk-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "nasi-uduk-D06")

    clone {
      datastore_id = "local-lvm"
      node_name = "its"
      vm_id = 5555
    }
    
    agent {
      enabled = false
    }

    initialization {
      ip_config { #eth0
        ipv4 {
          address = lookup(var.ip_list, "nasi-uduk-D06")
          gateway = lookup(var.gateaway_list, "nasi-uduk-D06")
        }
      }
      user_account {
        username = "D06"
        password = "hmd"
      }
    }

    cpu {
      cores = 1
      type = "x86-64-v2-AES"
    }

    memory {
      dedicated = 1024 # 1GB
      floating = 1024
    }

    disk {
      datastore_id = "local-lvm"
      file_id = "local:iso/focal-server-cloudimg-amd64.img"
      file_format = "raw"
      interface = "virtio0"
      iothread = true
      size = 3 # GB
    }

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}