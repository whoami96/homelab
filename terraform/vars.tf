variable "proxmox_api_url" {
  type = string
  default = "https://10.0.0.2:8006/api2/json"
}

variable "proxmox_api_user" {
    type = string
    default = "root@pam!terraform" 
}

variable "proxmox_api_key" {
    type = string
    default = "07b1e57e-81fe-4b15-8ffa-e3937bda4a6a"
}

variable "proxmox_lxc_default_password" {
    type = string
    default = "KamiKadz%#90"
}