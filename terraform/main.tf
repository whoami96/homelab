resource "proxmox_lxc" "docker-prod" {
    target_node  = "pve"
    hostname     = "docker-prod"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid = "103"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores = "4"
    memory = "4096"
    swap = "4096"
    description = "docker-prod"
    onboot = true
    ostype = "ubuntu"
    start = true
    tags = "terraform;docker-prod;internal"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "local-lvm"
        size    = "100G"
    }

    mountpoint {
        key = "0"
        slot = 0
        storage = "storage-ssd-fast"
        mp = "/mnt/nextcloud"
        size = "250G"
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

resource "proxmox_lxc" "docker-dev" {
    target_node  = "pve"
    hostname     = "docker-dev"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid = "104"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores = "2"
    memory = "2048"
    swap = "2048"
    description = "docker-dev"
    onboot = true
    ostype = "ubuntu"
    start = true
    tags = "terraform;docker-dev;internal"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "local-lvm"
        size    = "50G"
    }

    mountpoint {
        key = "0"
        slot = 0
        storage = "storage-ssd-fast"
        mp = "/mnt/data"
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

resource "proxmox_lxc" "proxy-manager" {
    target_node  = "pve"
    hostname     = "proxy-manager"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid = "105"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores = "1"
    memory = "512"
    swap = "512"
    description = "proxy-managr"
    onboot = true
    ostype = "ubuntu"
    start = true
    tags = "terraform;proxy-manager;internal"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "local-lvm"
        size    = "10G"
    }

    network {
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "10.0.0.5/24"
        gw = "10.0.0.1"
        ip6 = "auto"
    }

    features {
        nesting = true
    }
}