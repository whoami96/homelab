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
