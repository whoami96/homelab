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
    default = "cc2bb255-82d0-42b9-aac4-08aa6c73aa72"
}

variable "proxmox_lxc_default_password" {
    type = string
    default = "KamiKadz%#90"
}

variable "root_ssh_key" {
    type = string
    default = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBF4SPJpSUNzTQWwhRCLZTCTFZ3j5K6qcdkMBEf/h/NJ pawel@owczarczyk.it
  EOT
}