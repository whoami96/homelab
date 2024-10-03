resource "proxmox_lxc" "cockpit" {
    target_node  = "pve"
    hostname     = "cockpit"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid = "103"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores = "1"
    memory = "1024"
    swap = "1024"
    description = "cockpit"
    onboot = true
    ostype = "ubuntu"
    start = true
    tags = "terraform;cockpit"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "local-lvm"
        size    = "20G"
    }

    mountpoint {
        key = "0"
        slot = 0
        storage = "data"
        mp = "/data"
        size = "990G"
    }

    network {
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "10.0.0.3/24"
        gw = "10.0.0.1"
        ip6 = "auto"
    }

    features {
        nesting = true
    }
}

resource "proxmox_lxc" "docker" {
    target_node  = "pve"
    hostname     = "docker"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid = "104"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores = "4"
    memory = "4096"
    swap = "4096"
    description = "docker"
    onboot = true
    ostype = "ubuntu"
    start = true
    tags = "terraform;docker"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "local-lvm"
        size    = "50G"
    }
    
    mountpoint {
        key = "0"
        slot = 0
        storage = "disks"
        mp = "/data"
        size = "50G"
    }
    network {
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "10.0.0.4/24"
        gw = "10.0.0.1"
        ip6 = "auto"
    }

    features {
        nesting = true
    }
}
