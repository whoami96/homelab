resource "proxmox_lxc" "docker-prod" {
  target_node     = "pve"
  hostname        = "docker-prod"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "103"
  password        = var.proxmox_lxc_default_password
  unprivileged    = false
  cores           = "4"
  memory          = "4096"
  swap            = "4096"
  description     = "docker-prod"
  onboot          = true
  ostype          = "debian"
  start           = false
  tags            = "docker;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "100G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.3/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }

}

resource "proxmox_lxc" "pihole" {
  target_node     = "pve"
  hostname        = "pihole"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "104"
  password        = var.proxmox_lxc_default_password
  unprivileged    = true
  cores           = "1"
  memory          = "1024"
  swap            = "2048"
  description     = "pihole"
  onboot          = true
  ostype          = "debian"
  start           = false
  tags            = "docker;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "50G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.4/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }

}

resource "proxmox_lxc" "zbx" {
  target_node     = "pve"
  hostname        = "zbx"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "105"
  password        = var.proxmox_lxc_default_password
  unprivileged    = true
  cores           = "2"
  memory          = "2048"
  swap            = "2048"
  description     = "zbx"
  onboot          = true
  ostype          = "debian"
  start           = true
  tags            = "zbx;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "30G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.5/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }
  features {
    nesting = true
  }
}

resource "proxmox_lxc" "cloudflared" {
  target_node     = "pve"
  hostname        = "cloudflared"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "106"
  password        = var.proxmox_lxc_default_password
  unprivileged    = true
  cores           = "1"
  memory          = "512"
  swap            = "512"
  description     = "cloudflared"
  onboot          = true
  ostype          = "ubuntu"
  start           = true
  tags            = "cloudflared;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "30G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.6/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }
  features {
    nesting = true
  }
}

resource "proxmox_lxc" "pbs" {
  target_node     = "pve"
  hostname        = "pbs"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "107"
  password        = var.proxmox_lxc_default_password
  unprivileged    = true
  cores           = "2"
  memory          = "2048"
  swap            = "2048"
  description     = "pbs"
  onboot          = true
  ostype          = "debian"
  start           = false
  tags            = "pbs;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "50G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    mp      = "/mnt/backup"
    storage = "hdd_storage"
    size    = "800G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.7/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }

  features {
    nesting = true
  }
}

resource "proxmox_lxc" "mariadb" {
  target_node     = "pve"
  hostname        = "mariadb"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "108"
  password        = var.proxmox_lxc_default_password
  unprivileged    = true
  cores           = "2"
  memory          = "2048"
  swap            = "2048"
  description     = "mariadb"
  onboot          = true
  ostype          = "debian"
  start           = true
  tags            = "mariadb;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "100G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.8/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }

  features {
    nesting = true
  }
}

resource "proxmox_lxc" "semaphore" {
  target_node     = "pve"
  hostname        = "semaphore"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "109"
  password        = var.proxmox_lxc_default_password
  unprivileged    = false
  cores           = "2"
  memory          = "2048"
  swap            = "2048"
  description     = "semaphore"
  onboot          = true
  ostype          = "debian"
  start           = false
  tags            = "semaphore;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "50G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.9/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }

  features {
    nesting = true
  }
}

resource "proxmox_lxc" "nextcloud" {
  target_node     = "pve"
  hostname        = "nextcloud"
  ostemplate      = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  vmid            = "110"
  password        = var.proxmox_lxc_default_password
  unprivileged    = true
  cores           = "2"
  memory          = "2048"
  swap            = "2048"
  description     = "nextcloud"
  onboot          = true
  ostype          = "debian"
  start           = true
  tags            = "nextcloud;debian;lxc;terraform"
  ssh_public_keys = var.root_ssh_key

  rootfs {
    storage = "pve_storage"
    size    = "50G"
  }

  mountpoint {
    key     = "0"
    slot    = 0
    mp      = "/mnt/nextcloud"
    storage = "nextcloud_storage"
    size    = "200G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.0.0.10/24"
    gw     = "10.0.0.1"
    ip6    = "manual"
  }

  features {
    nesting = true
  }
}