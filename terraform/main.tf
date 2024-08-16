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
    tags = "terraform;docker-prod"

    rootfs {
        storage = "local-lvm"
        size    = "100G"
    }

    mountpoint {
        key = "0"
        slot = 0
        storage = "storage-ssd"
        mp = "/mnt/nextcloud"
        size = "250G"
    }

    network {
        name   = "eth0"
        bridge = "vmbr0"
        ip     = "10.0.0.3/24"
        gw = "10.0.0.1"
    }

    features {
        nesting = true
    }
}