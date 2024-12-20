resource "proxmox_lxc" "docker" {
    target_node  = "pve"
    hostname     = "docker"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid         = "111"
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
        ip     = "192.168.0.11/24"
        gw     = "192.168.0.1"
        ip6    = "auto"
    }

    features {
        nesting = true
    }
}

resource "proxmox_lxc" "nextcloud" {
    target_node = "pve"
    hostname    = "nextcloud"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid         = "112"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores        = "2"
    memory       = "2048"
    swap         = "4096"
    description  = "nextcloud"
    onboot       = true
    ostype       = "ubuntu"
    start        = true
    tags         = "terraform;nextcloud;lxc"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "ssd_storage"
        size = "500G"
    }

    network {
        name     = "eth0"
        bridge   = "vmbr0"
        ip       = "192.168.0.12/24"
        gw       = "192.168.0.1"
        ip6      = "auto"  
    }
}

resource "proxmox_lxc" "gitea" {
    target_node = "pve"
    hostname    = "gitea"
    ostemplate   = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    vmid         = "113"
    password     = var.proxmox_lxc_default_password
    unprivileged = true
    cores        = "2"
    memory       = "2048"
    swap         = "4096"
    description  = "gitea"
    onboot       = true
    ostype       = "ubuntu"
    start        = true
    tags         = "terraform;gitea;lxc"
    ssh_public_keys = var.root_ssh_key

    rootfs {
        storage = "ssd_storage"
        size = "50G"
    }

    network {
        name     = "eth0"
        bridge   = "vmbr0"
        ip       = "192.168.0.13/24"
        gw       = "192.168.0.1"
        ip6      = "auto"  
    }
}