resource "proxmox_lxc" "storage" {
    target_node  = "pve"
    hostname     = "storage"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid         = "103"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores        = "2"
    memory       = "2048"
    swap         = "2048"
    description  = "storage"
    onboot       = true
    ostype       = "ubuntu"
    start        = true
    tags         = "terraform;storage;lxc"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "local-lvm"
        size    = "20G"
    }

    mountpoint {
        slot    = 0
        key     = "0"
        size    = "900G"
        mp      = "/mnt/storage"
        storage = "hdd_storage"
    }

    network {
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "10.0.0.3/24"
        gw     = "10.0.0.1"
        ip6    = "auto"
    }

    features {
        nesting = true
    }
}

resource "proxmox_lxc" "docker" {
    target_node  = "pve"
    hostname     = "docker"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid         = "104"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores        = "4"
    memory       = "4096"
    swap         = "4096"
    description  = "docker"
    onboot       = true
    ostype       = "ubuntu"
    start        = true
    tags         = "terraform;docker;lxc"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "ssd_storage"
        size    = "100G"
    }

    network {
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "10.0.0.4/24"
        gw     = "10.0.0.1"
        ip6    = "auto"
    }

    features {
        nesting = true
    }
}
