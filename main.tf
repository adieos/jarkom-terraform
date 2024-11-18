terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.1"
    }
  }
}

// command: (ganti geprek dengan node yang sesuai)
// terraform apply --target=proxmox_virtual_environment_file.cloud_config-geprek --target=proxmox_virtual_environment_vm.geprek-D06

provider "proxmox" {
  endpoint = var.proxmox_url
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

// files for clients & servers
resource "proxmox_virtual_environment_file" "cloud_config-geprek" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-geprek-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-nasi-uduk" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-nasi-uduk-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-kwetiaw" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-kwetiaw-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-pangsit" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-pangsit-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-naspad" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-naspad-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-ikan-fillet" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-ikan-fillet-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-tahu-tek" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-tahu-tek-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-sego-jamur" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    EOF

    file_name = "cloud-config-sego-jamur-D06.yaml"
  }
}



// Clients & Servers
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
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-nasi-uduk.id
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

resource "proxmox_virtual_environment_vm" "geprek-D06" {
    name = "geprek-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "geprek-D06")

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
          address = lookup(var.ip_list, "geprek-D06")
          gateway = lookup(var.gateaway_list, "geprek-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-geprek.id
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


resource "proxmox_virtual_environment_vm" "kwetiaw-D06" {
    name = "kwetiaw-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "kwetiaw-D06")

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
          address = lookup(var.ip_list, "kwetiaw-D06")
          gateway = lookup(var.gateaway_list, "kwetiaw-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-kwetiaw.id
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


resource "proxmox_virtual_environment_vm" "pangsit-D06" {
    name = "pangsit-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "pangsit-D06")

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
          address = lookup(var.ip_list, "pangsit-D06")
          gateway = lookup(var.gateaway_list, "pangsit-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-pangsit.id
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


resource "proxmox_virtual_environment_vm" "naspad-D06" {
    name = "naspad-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "naspad-D06")

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
          address = lookup(var.ip_list, "naspad-D06")
          gateway = lookup(var.gateaway_list, "naspad-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-naspad.id
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


resource "proxmox_virtual_environment_vm" "ikan-fillet-D06" {
    name = "ikan-fillet-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "ikan-fillet-D06")

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
          address = lookup(var.ip_list, "ikan-fillet-D06")
          gateway = lookup(var.gateaway_list, "ikan-fillet-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-ikan-fillet.id
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


resource "proxmox_virtual_environment_vm" "tahu-tek-D06" {
    name = "tahu-tek-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "tahu-tek-D06")

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
          address = lookup(var.ip_list, "tahu-tek-D06")
          gateway = lookup(var.gateaway_list, "tahu-tek-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-tahu-tek.id
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


resource "proxmox_virtual_environment_vm" "sego-jamur-D06" {
    name = "sego-jamur-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "sego-jamur-D06")

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
          address = lookup(var.ip_list, "sego-jamur-D06")
          gateway = lookup(var.gateaway_list, "sego-jamur-D06")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-sego-jamur.id
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

// ROUTERS

// files for routers
resource "proxmox_virtual_environment_file" "cloud_config-alfamart" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - sysctl -w net.ipv4.ip_forward=1
      - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
      - netplan apply
      - ip link set eth0 up 
      - ip link set eth1 up 
      - ip link set eth2 up 
      - ip route add 0.0.0.0/0 via 192.168.6.5 #ALFAMARTviaINDOMARET
      - echo "Initialization complete" > /tmp/init_done
    EOF

    file_name = "cloud-config-alfamart-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-sakinah" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - sysctl -w net.ipv4.ip_forward=1
      - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
      - netplan apply
      - ip link set eth0 up
      - ip link set eth1 up
      - ip route add 0.0.0.0/0 via 192.168.6.17
      - echo "Initialization complete" > /tmp/init_done
    EOF

    file_name = "cloud-config-sakinah-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-its-mart" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - sysctl -w net.ipv4.ip_forward=1
      - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
      - netplan apply
      - ip link set eth0 up
      - ip link set eth1 up
      -  ip route add 0.0.0.0/0 via 192.168.6.41
      - echo "Initialization complete" > /tmp/init_done
    EOF

    file_name = "cloud-config-its-mart-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-superindo" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - sysctl -w net.ipv4.ip_forward=1
      - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
      - netplan apply
      - ip link set eth0 up
      - ip link set eth1 up
      - ip link set eth2 up
      - ip route add 192.168.6.48/29 via 192.168.6.42
      - ip route add 192.168.6.56/29 via 192.168.6.18
      - ip route add 0.0.0.0/0 via 192.168.6.13
      - echo "Initialization complete" > /tmp/init_done
    EOF

    file_name = "cloud-config-superindo-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-indomaret" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - sysctl -w net.ipv4.ip_forward=1
      - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
      - netplan apply
      - ip link set eth0 up
      - ip link set eth1 up
      - ip route add 192.168.6.32/29 via 192.168.6.6
      - ip route add 192.168.6.0/30 via 192.168.6.6
      - ip route add 0.0.0.0/0 via 192.168.6.9
      - echo "Initialization complete" > /tmp/init_done
    EOF

    file_name = "cloud-config-indomaret-D06.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config-family-mart" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "its"

  source_raw {
    data = <<-EOF
    #cloud-config
    groups:
      - admingroup: [root, sys]
      - cloud-users
    users:
      - default
      - name: asahitamlegam
        plain_text_passwd: acc
        groups: sudo
        shell: /bin/bash
        lock_passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - sysctl -w net.ipv4.ip_forward=1
      - echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
      - netplan apply
      - ip link set eth0 up
      - ip link set eth1 up
      - ip link set eth2 up
      - ip route add 192.168.6.0/30 via 192.168.6.10
      - ip route add 192.168.6.4/30 via 192.168.6.10
      - ip route add 192.168.6.32/29 via 192.168.6.10
      - ip route add 192.168.6.40/29 via 192.168.6.14
      - ip route add 192.168.6.48/29 via 192.168.6.14
      - ip route add 192.168.6.56/29 via 192.168.6.14
      - ip route add 192.168.6.16/30 via 192.168.6.14
      - echo "Initialization complete" > /tmp/init_done
    EOF

    file_name = "cloud-config-family-mart-D06.yaml"
  }
}

// routers
resource "proxmox_virtual_environment_vm" "alfamart-D06" {
    name = "alfamart-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "alfamart-D06")
    user_data_file_id = proxmox_virtual_environment_file.cloud_config-alfamart.id

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
          address = lookup(var.ip_list, "alfamart-eth0")
          gateway = lookup(var.gateaway_list, "alfamart-eth0")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "alfamart-sw1")
        }
      }
      ip_config { #eth2
        ipv4 {
          address = lookup(var.ip_list, "alfamart-sw2")
        }
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

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}

resource "proxmox_virtual_environment_vm" "sakinah-D06" {
    name = "sakinah-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "sakinah-D06")

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
          address = lookup(var.ip_list, "sakinah-superindo")
          gateway = lookup(var.gateaway_list, "sakinah-superindo")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "sakinah-sw3")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-sakinah.id
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

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}

resource "proxmox_virtual_environment_vm" "its-mart-D06" {
    name = "its-mart-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "its-mart-D06")

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
        ipv4 { // A6
          address = lookup(var.ip_list, "its-mart-sw4")
          gateway = lookup(var.gateaway_list, "its-mart-sw4")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "its-mart-sw5")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-its-mart.id
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

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}

resource "proxmox_virtual_environment_vm" "superindo-D06" {
    name = "superindo-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "superindo-D06")

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
          address = lookup(var.ip_list, "superindo-eth0")
          gateway = lookup(var.gateaway_list, "superindo-eth0")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "superindo-sw4")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "superindo-sakinah")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-superindo.id
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

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}

resource "proxmox_virtual_environment_vm" "indomaret-D06" {
    name = "indomaret-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "indomaret-D06")

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
          address = lookup(var.ip_list, "indomaret-eth0")
          gateway = lookup(var.gateaway_list, "indomaret-eth0")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "infomaret-eth1")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-indomaret.id
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

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}

resource "proxmox_virtual_environment_vm" "family-mart-D06" {
    name = "family-mart-D06"
    node_name = "its"
    on_boot = true
    stop_on_destroy = true
    scsi_hardware = "virtio-scsi-single"
    vm_id = lookup(var.vm_id_list, "family-mart-D06")

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
          address = lookup(var.ip_list, "family-mart-eth1")
        }
      }
      ip_config { #eth1
        ipv4 {
          address = lookup(var.ip_list, "family-mart-eth2")
        }
      }
      user_data_file_id = proxmox_virtual_environment_file.cloud_config-family-mart.id
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

    network_device {
      enabled = true
      firewall = false
      bridge = "vmbr0"
    }
}